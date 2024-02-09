import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mada_jeune/data/models/api_response.dart';
import 'package:mada_jeune/data/models/ville/ville_model.dart';
import 'package:mada_jeune/data/services/ville/ville_service.dart';

class DropDownVille extends StatefulWidget {
  DropDownVille({super.key, required this.onChanged, required this.onSelected});
  ValueChanged<String> onChanged = (String value) {};
  ValueChanged<String> onSelected = (String value) {};

  @override
  State<DropDownVille> createState() => _DropDownVilleState();
}

class _DropDownVilleState extends State<DropDownVille> {
  String? dropdownValue = "";

  VilleService get villeService => GetIt.I<VilleService>();

  late APIResponse<List<VilleModel>> _apiResponse = APIResponse<List<VilleModel>>(data: []);
  bool _isloading = false;

  @override
  void initState() {
    _fetchVilles();

    if (kDebugMode) {
      print(dropdownValue);
    }
    super.initState();
  }

  _fetchVilles() async {
    setState(() {
      _isloading = true;
    });
    _apiResponse = await villeService.getAllVille();
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_apiResponse.data == null || _apiResponse.data!.isEmpty) {
      return const Center(
        //child: CircularProgressIndicator(), // Afficher un indicateur de chargement si la liste est vide
        //child: Lottie.asset('assets/animations/line.json'), // Remplacez par votre animation Lottie
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: DropdownMenu<VilleModel>(
            width: 250,
            controller: TextEditingController(text: dropdownValue ?? ""),
            enableFilter: true,
            requestFocusOnTap: true,
            leadingIcon: const Icon(Icons.search),
            label: const Text("Ville"),
            onSelected: (VilleModel? value) {
              setState(() {
                dropdownValue = value?.nomVille ?? "";
                widget.onChanged(value!.idVille.toString());
                widget.onSelected(value.nomVille.toString());
              });
            },
            dropdownMenuEntries: _apiResponse.data!.map<DropdownMenuEntry<VilleModel>>((VilleModel value) {
              return DropdownMenuEntry<VilleModel>(
                value: value,
                label: value.nomVille,
              );
            }).toList(),
          ),
        ), // Espacement entre le DropdownMenu et le Text
        Text(
          '$dropdownValue *',
          style: const TextStyle(fontSize: 10),
        ),
      ],
    );
  }
}
