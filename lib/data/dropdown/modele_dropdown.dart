import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:mada_jeune/data/models/api_response.dart';
import 'package:mada_jeune/data/models/model/model_model.dart';
import 'package:mada_jeune/data/services/model/model_service.dart';

class DropDownModele extends StatefulWidget {
  DropDownModele({super.key, required this.onChanged, required this.onSelected, required this.onModelSelected});
  ValueChanged<String> onChanged = (String value) {};
  ValueChanged<String> onSelected = (String value) {};
  ValueChanged<ModelModel> onModelSelected = (ModelModel value) {};

  @override
  State<DropDownModele> createState() => _DropDownModeleState();
}

class _DropDownModeleState extends State<DropDownModele> {
  String? dropdownValue = "";
  ModelModel? modelModel;

  ModelService get modeleService => GetIt.I<ModelService>();

  late APIResponse<List<ModelModel>> _apiResponse = APIResponse<List<ModelModel>>(data: []);
  bool _isloading = false;

  @override
  void initState() {
    _fetchModeles();
    super.initState();
  }

  _fetchModeles() async {
    setState(() {
      _isloading = true;
    });
    _apiResponse = await modeleService.getAllModel();
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
          child: DropdownMenu<ModelModel>(
            width: 250,
            controller: TextEditingController(text: dropdownValue ?? ""),
            enableFilter: true,
            requestFocusOnTap: true,
            leadingIcon: const Icon(Icons.search),
            label: const Text("Modele"),
            onSelected: (ModelModel? value) {
              setState(() {
                dropdownValue = value?.nomModele ?? "";
                widget.onChanged(value!.idModele.toString());
                widget.onSelected(value.nomModele.toString());
                widget.onModelSelected(value);
              });
            },
            dropdownMenuEntries: _apiResponse.data!.map<DropdownMenuEntry<ModelModel>>((ModelModel value) {
              return DropdownMenuEntry<ModelModel>(
                value: value,
                label: value.nomModele,
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