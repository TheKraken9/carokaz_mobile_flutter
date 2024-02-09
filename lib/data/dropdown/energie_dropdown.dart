import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mada_jeune/data/models/api_response.dart';
import 'package:mada_jeune/data/models/energie/energie_model.dart';
import 'package:mada_jeune/data/services/energie/energie_service.dart';

class DropDownEnergie extends StatefulWidget {
  DropDownEnergie({super.key, required this.onChanged, required this.onSelected});
  ValueChanged<String> onChanged = (String value) {};
  ValueChanged<String> onSelected = (String value) {};

  @override
  State<DropDownEnergie> createState() => _DropDownEnergieState();
}

class _DropDownEnergieState extends State<DropDownEnergie> {
  String? dropdownValue = "";

  EnergieService get energieService => GetIt.I<EnergieService>();

  late APIResponse<List<EnergieModel>> _apiResponse = APIResponse<List<EnergieModel>>(data: []);
  bool _isloading = false;

  @override
  void initState() {
    _fetchEnergies();
    super.initState();
  }

  _fetchEnergies() async {
    setState(() {
      _isloading = true;
    });
    _apiResponse = await energieService.getAllEnergie();
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_apiResponse.data!.isEmpty) {
      return const Center(
        //child: CircularProgressIndicator(), // Afficher un indicateur de chargement si la liste est vide
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: DropdownMenu<EnergieModel>(
            width: 250,
            controller: TextEditingController(text: dropdownValue ?? ""),
            enableFilter: true,
            requestFocusOnTap: true,
            leadingIcon: const Icon(Icons.search),
            label: const Text("Energie"),
            onSelected: (EnergieModel? value) {
              setState(() {
                dropdownValue = value?.nomEnergie ?? "";
                widget.onChanged(value!.idEnergie.toString());
                widget.onSelected(value.nomEnergie.toString());
              });
            },
            dropdownMenuEntries: _apiResponse.data!.map<DropdownMenuEntry<EnergieModel>>((EnergieModel value) {
              return DropdownMenuEntry<EnergieModel>(
                value: value,
                label: value.nomEnergie,
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
