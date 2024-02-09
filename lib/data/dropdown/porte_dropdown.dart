import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:mada_jeune/data/models/api_response.dart';
import 'package:mada_jeune/data/models/porte/porte_model.dart';
import 'package:mada_jeune/data/services/porte/porte_service.dart';

class DropDownPorte extends StatefulWidget {
  DropDownPorte({super.key, required this.onChanged, required this.onSelected});
  ValueChanged<String> onChanged = (String value) {};
  ValueChanged<String> onSelected = (String value) {};

  @override
  State<DropDownPorte> createState() => _DropDownPorteState();
}

class _DropDownPorteState extends State<DropDownPorte> {
  String? dropdownValue = "";

  PorteService get porteService => GetIt.I<PorteService>();

  late APIResponse<List<PorteModel>> _apiResponse = APIResponse<List<PorteModel>>(data: []);
  bool _isloading = false;

  @override
  void initState() {
    _fetchPortes();
    super.initState();
  }

  _fetchPortes() async {
    setState(() {
      _isloading = true;
    });
    _apiResponse = await porteService.getAllPorte();
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_apiResponse.data!.isEmpty) {
      return const Center(
        //child: CircularProgressIndicator(), // Afficher un indicateur de chargement si la liste est vide
        //child: Lottie.asset('assets/animations/line.json'), // Remplacez par votre animation Lottie
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: DropdownMenu<PorteModel>(
            width: 250,
            controller: TextEditingController(text: dropdownValue ?? ""),
            enableFilter: true,
            requestFocusOnTap: true,
            leadingIcon: const Icon(Icons.search),
            label: const Text("Nombre de porte"),
            onSelected: (PorteModel? value) {
              setState(() {
                dropdownValue = value?.valeur.toString() ?? "";
                widget.onChanged(value!.idPorte.toString());
                widget.onSelected(value.valeur.toString());
              });
            },
            dropdownMenuEntries: _apiResponse.data!.map<DropdownMenuEntry<PorteModel>>((PorteModel value) {
              return DropdownMenuEntry<PorteModel>(
                value: value,
                label: value.valeur.toString(),
              );
            }).toList(),
          ),
        ),
        Text(
          '$dropdownValue *',
          style: const TextStyle(fontSize: 10),
        )
      ],
    );
  }
}
