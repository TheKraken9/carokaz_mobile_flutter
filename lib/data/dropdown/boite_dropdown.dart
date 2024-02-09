import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mada_jeune/data/models/api_response.dart';
import 'package:mada_jeune/data/models/boite/boite_model.dart';
import 'package:mada_jeune/data/services/boite/boite_service.dart';

class DropDownBoite extends StatefulWidget {
  DropDownBoite({super.key, required this.onChanged, required this.onSelected});
  ValueChanged<String> onChanged = (String value) {};
  ValueChanged<String> onSelected = (String value) {};

  @override
  State<DropDownBoite> createState() => _DropDownBoiteState();
}

class _DropDownBoiteState extends State<DropDownBoite> {
  String? dropdownValue = "";

  BoiteService get boiteService => GetIt.I<BoiteService>();

  late APIResponse<List<BoiteModel>> _apiResponse = APIResponse<List<BoiteModel>>(data: []);
  bool _isloading = false;

  @override
  void initState() {
    _fetchBoites();
    super.initState();
  }

  _fetchBoites() async {
    setState(() {
      _isloading = true;
    });
    _apiResponse = await boiteService.getAllBoite();
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
          child: DropdownMenu<BoiteModel>(
            width: 250,
            controller: TextEditingController(text: dropdownValue ?? ""),
            enableFilter: true,
            requestFocusOnTap: true,
            leadingIcon: const Icon(Icons.search),
            label: const Text("Boite"),
            onSelected: (BoiteModel? value) {
              setState(() {
                dropdownValue = value?.nomBoite ?? "";
                widget.onChanged(value!.idBoite.toString());
                widget.onSelected(value.nomBoite.toString());
              });
            },
            dropdownMenuEntries: _apiResponse.data!.map<DropdownMenuEntry<BoiteModel>>((BoiteModel value) {
              return DropdownMenuEntry<BoiteModel>(
                value: value,
                label: value.nomBoite,
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
