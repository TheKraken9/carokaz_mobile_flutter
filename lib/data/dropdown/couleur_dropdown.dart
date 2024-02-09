import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mada_jeune/data/models/api_response.dart';
import 'package:mada_jeune/data/models/couleur/couleur_model.dart';
import 'package:mada_jeune/data/services/couleur/couleur_service.dart';

class DropDownCouleur extends StatefulWidget {
  DropDownCouleur({super.key, required this.onChanged, required this.onSelected});
  ValueChanged<String> onChanged = (String value) {};
  ValueChanged<String> onSelected = (String value) {};

  @override
  State<DropDownCouleur> createState() => _DropDownCouleurState();
}

class _DropDownCouleurState extends State<DropDownCouleur> {
  String? dropdownValue = "";

  CouleurService get couleurService => GetIt.I<CouleurService>();

  late APIResponse<List<CouleurModel>> _apiResponse = APIResponse<List<CouleurModel>>(data: []);
  bool _isloading = false;

  @override
  void initState() {
    _fetchCouleurs();
    super.initState();
  }

  _fetchCouleurs() async {
    setState(() {
      _isloading = true;
    });
    _apiResponse = await couleurService.getAllCouleur();
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
    if (kDebugMode) {
      print(_apiResponse.data!);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: DropdownMenu<CouleurModel>(
            width: 250,
            controller: TextEditingController(text: dropdownValue ?? ""),
            enableFilter: true,
            requestFocusOnTap: true,
            leadingIcon: const Icon(Icons.search),
            label: const Text("Couleur"),
            onSelected: (CouleurModel? value) {
              setState(() {
                dropdownValue = value?.nomCouleur ?? "";
                widget.onChanged(value!.idCouleur.toString());
                widget.onSelected(value.nomCouleur.toString());
              });
            },
            dropdownMenuEntries: _apiResponse.data!.map<DropdownMenuEntry<CouleurModel>>((CouleurModel value) {
              return DropdownMenuEntry<CouleurModel>(
                value: value,
                label: value.nomCouleur,
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
