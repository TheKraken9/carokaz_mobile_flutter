import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:mada_jeune/data/models/api_response.dart';
import 'package:mada_jeune/data/models/place/place_model.dart';
import 'package:mada_jeune/data/services/place/place_service.dart';

class DropDownPlace extends StatefulWidget {
  DropDownPlace({super.key, required this.onChanged, required this.onSelected});
  ValueChanged<String> onChanged = (String value) {};
  ValueChanged<String> onSelected = (String value) {};

  @override
  State<DropDownPlace> createState() => _DropDownPlaceState();
}

class _DropDownPlaceState extends State<DropDownPlace> {
  String? dropdownValue = "";

  PlaceService get placeService => GetIt.I<PlaceService>();

  late APIResponse<List<PlaceModel>> _apiResponse = APIResponse<List<PlaceModel>>(data: []);
  bool _isloading = false;

  @override
  void initState() {
    _fetchPlaces();
    super.initState();
  }

  _fetchPlaces() async {
    setState(() {
      _isloading = true;
    });
    _apiResponse = await placeService.getAllPlace();
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
          child: DropdownMenu<PlaceModel>(
            width: 250,
            controller: TextEditingController(text: dropdownValue ?? ""),
            enableFilter: true,
            requestFocusOnTap: true,
            leadingIcon: const Icon(Icons.search),
            label: const Text("Nombre de place"),
            onSelected: (PlaceModel? value) {
              setState(() {
                dropdownValue = value?.valeur.toString() ?? "";
                widget.onChanged(value!.idPlace.toString());
                widget.onSelected(value.valeur.toString());
              });
            },
            dropdownMenuEntries: _apiResponse.data!.map<DropdownMenuEntry<PlaceModel>>((PlaceModel value) {
              return DropdownMenuEntry<PlaceModel>(
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
