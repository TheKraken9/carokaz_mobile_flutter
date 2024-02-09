import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:mada_jeune/data/models/api_response.dart';
import 'package:mada_jeune/data/models/categorie/categorie_model.dart';
import 'package:mada_jeune/data/services/categorie/categorie_service.dart';

class DropDownCategorie extends StatefulWidget {
  DropDownCategorie({super.key, required this.onChanged, required this.onSelected});
  ValueChanged<String> onChanged = (String value) {};
  ValueChanged<String> onSelected = (String value) {};

  @override
  State<DropDownCategorie> createState() => _DropDownCategorieState();
}

class _DropDownCategorieState extends State<DropDownCategorie> {
  String? dropdownValue = "";

  CategorieService get categorieService => GetIt.I<CategorieService>();

  late APIResponse<List<CategorieModel>> _apiResponse = APIResponse<List<CategorieModel>>(data: []);
  bool _isloading = false;

  @override
  void initState() {
    _fetchCategories();
    super.initState();
  }

  _fetchCategories() async {
    setState(() {
      _isloading = true;
    });
    _apiResponse = await categorieService.getAllCategorie();
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
          child: DropdownMenu<CategorieModel>(
            width: 250,
            controller: TextEditingController(text: dropdownValue ?? ""),
            enableFilter: true,
            requestFocusOnTap: true,
            leadingIcon: const Icon(Icons.search),
            label: const Text("Categorie"),
            onSelected: (CategorieModel? value) {
              setState(() {
                dropdownValue = value?.nomCategorie ?? "";
                widget.onChanged(value!.idCategorie.toString());
                widget.onSelected(value.nomCategorie.toString());
              });
            },
            dropdownMenuEntries: _apiResponse.data!.map<DropdownMenuEntry<CategorieModel>>((CategorieModel value) {
              return DropdownMenuEntry<CategorieModel>(
                value: value,
                label: value.nomCategorie,
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
