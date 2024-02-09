import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:mada_jeune/data/models/api_response.dart';
import 'package:mada_jeune/data/models/marque/marque_model.dart';
import 'package:mada_jeune/data/services/marque/marque_service.dart';

class DropDownMarque extends StatefulWidget {
  DropDownMarque({super.key, required this.onChanged, required this.onSelected});
  ValueChanged<String> onChanged = (String value) {};
  ValueChanged<String> onSelected = (String value) {};

  @override
  State<DropDownMarque> createState() => _DropDownMarqueState();
}

class _DropDownMarqueState extends State<DropDownMarque> {
  String? dropdownValue = "";

  MarqueService get marqueService => GetIt.I<MarqueService>();

  late APIResponse<List<MarqueModel>> _apiResponse = APIResponse<List<MarqueModel>>(data: []);
  bool _isloading = false;

  @override
  void initState() {
    _fetchMarques();
    if (kDebugMode) {
      print(dropdownValue);
    }
    super.initState();
  }

  _fetchMarques() async {
    setState(() {
      _isloading = true;
    });
    _apiResponse = await marqueService.getAllMarque();
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_apiResponse.data!.isEmpty && _apiResponse.data!.isEmpty) {
      return const Center(
        //child: CircularProgressIndicator(), // Afficher un indicateur de chargement si la liste est vide
        //child: Lottie.asset('assets/animations/line.json'), // Remplacez par votre animation Lottie
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: DropdownMenu<MarqueModel>(
            width: 250,
            controller: TextEditingController(text: dropdownValue ?? ""),
            enableSearch: true,
            requestFocusOnTap: true,
            leadingIcon: const Icon(Icons.search),
            label: const Text("Marque"),
            onSelected: (MarqueModel? value) {
              setState(() {
                dropdownValue = value?.nomMarque ?? "";
                widget.onChanged(value!.idMarque.toString());
                widget.onSelected(value.nomMarque.toString());
              });
            },
            dropdownMenuEntries: _apiResponse.data!.map<DropdownMenuEntry<MarqueModel>>((MarqueModel value) {
              return DropdownMenuEntry<MarqueModel>(
                value: value,
                label: value.nomMarque,
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
