import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:mada_jeune/commons/widgets/appbar/appbar.dart';
import 'package:mada_jeune/commons/widgets/loaders/loaders.dart';
import 'package:mada_jeune/data/dropdown/boite_dropdown.dart';
import 'package:mada_jeune/data/dropdown/categorie_dropdown.dart';
import 'package:mada_jeune/data/dropdown/couleur_dropdown.dart';
import 'package:mada_jeune/data/dropdown/energie_dropdown.dart';
import 'package:mada_jeune/data/dropdown/etat_dropdown.dart';
import 'package:mada_jeune/data/dropdown/marque_dropdown.dart';
import 'package:mada_jeune/data/dropdown/modele_dropdown.dart';
import 'package:mada_jeune/data/dropdown/place_dropdown.dart';
import 'package:mada_jeune/data/dropdown/porte_dropdown.dart';
import 'package:mada_jeune/data/dropdown/ville_dropdown.dart';
import 'package:mada_jeune/data/models/model/model_model.dart';
import 'package:mada_jeune/features/authentication/controller/annonce/annonce_controller.dart';
import 'package:mada_jeune/features/authentication/controller/image/image_controller.dart';
import 'package:mada_jeune/utils/constants/color.dart';
import 'package:mada_jeune/utils/constants/sizes.dart';
import 'package:mada_jeune/utils/validators/validation.dart';


class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({Key? key}) : super(key: key);

  @override
  _AddNewAddressScreenState createState() => _AddNewAddressScreenState();
}


class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final ImagePicker imagePicker = ImagePicker();
  ImageController imageController = ImageController();
  List<XFile> imageFileList = [];
  void selectImages() async {
    try {
      final XFile? images = await ImagePicker().pickImage(
          source: ImageSource.gallery);

      if (images == null) return;
      final imageTemporary = File(images.path);

      setState(() => imageFileList = [...imageFileList, images]);
    } on PlatformException catch (e) {
      TLoaders.errorSnackBar(title: "Erreur", message: e.message ?? '');
    }
  }

  void selectMultipleImages() async {
    try {
      final List<XFile>? images = await ImagePicker().pickMultiImage();

      if (images == null) return;
      final imageTemporary = File(images[0].path);

      setState(() {
        imageFileList = [...imageFileList, ...images];
        imageController.selectedFileCount.value = images.length;
      });
    } on PlatformException catch (e) {
      TLoaders.errorSnackBar(title: "Erreur", message: e.message ?? '');
    }
  }

  void removeImage(int index) {
    setState(() {
      imageFileList.removeAt(index);
      imageController.selectedFileCount.value = imageFileList.length;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  ModelModel? selectedModel;

  String selectedVille = "";
  String selectedVilleValue = "";

  String selectedMarque = "";
  String selectedMarqueValue = "";

  String selectedModele = "";
  String selectedModeleValue = "";

  String selectedCategorie = "";
  String selectedCategorieValue = "";

  String selectedPorte = "";
  String selectedPorteValue = "";

  String selectedPlace = "";
  String selectedPlaceValue = "";

  String selectedEnergie = "";
  String selectedEnergieValue = "";

  String selectedBoite = "";
  String selectedBoiteValue = "";

  String selectedCouleur = "";
  String selectedCouleurValue = "";

  String selectedEtat = "";

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _kilometrageController = TextEditingController();
  final TextEditingController _consommationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _prixController = TextEditingController();

  int _currentStep = 0;
  String base64Image = "";
  List<String> listBase64Image = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    ImageController imageController = Get.put(ImageController());
    final AnnonceController annonceController = Get.put(AnnonceController());
    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: Text('Ajouter une annonce')),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: TColors.primary),
        ),
        child: Form(
          key: _formKey,
          child: Stepper(
            type: StepperType.horizontal,
            currentStep: _currentStep,
            elevation: 0,
            controlsBuilder: (context, controller) {
              return const SizedBox.shrink();
            },
            onStepContinue: () {
              setState(() {
                _currentStep < 3 ? _currentStep += 1 : null;
              });
            },
            onStepCancel: () {
              setState(() {
                _currentStep > 0 ? _currentStep -= 1 : null;
              });
            },
            steps: [
              Step(
                title: const Text('Base'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //DropDownMarque(onChanged: (String value) { selectedMarque = value; }, onSelected: (String name) { selectedMarqueValue = name; },),
                    //const SizedBox(height: TSizes.spaceBtwInputFields),
                    Row(
                      children: [
                        Expanded(child: DropDownModele(
                          onChanged: (String value) {
                            selectedModele = value; },
                          onSelected: (String name) {
                            selectedModeleValue = name;
                            },
                          onModelSelected: (ModelModel value) {
                            selectedModel = value; },),),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    Row(
                      children: [
                        SizedBox(
                          width: 250, // Largeur fixe du premier TextFormField
                          child: TextFormField(
                            controller: _kilometrageController,
                            validator: (value) => TValidator.validateEmptyText('Kilometrage', value),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.ruler),
                              labelText: 'Kilometrage',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    Row(
                      children: [
                        SizedBox(
                          width: 250, // Largeur fixe du deuxième TextFormField
                          child: TextFormField(
                            controller: _consommationController,
                            validator: (value) => TValidator.validateEmptyText('Consommation', value),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.speedometer),
                              labelText: 'Consommation',
                            ),
                          ),
                        ),
                      ]
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    Row(
                        children: [
                          SizedBox(
                            width: 250, // Largeur fixe du deuxième TextFormField
                            child: TextFormField(
                              controller: _prixController,
                              validator: (value) => TValidator.validateEmptyText('Prix', value),
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.money),
                                labelText: 'Prix',
                              ),
                            ),
                          ),
                        ]
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    Row(
                      children: [
                        Expanded(child: DropDownEtat(onChanged: (String value) { selectedEtat = value; },)),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    Row(
                      children: [
                        Expanded(child: DropDownVille(
                          onChanged: (String value) {
                            selectedVille = value;
                            },
                          onSelected: (String name) {
                            selectedVilleValue = name;
                            },)),
                      ],
                    ),
                  ],
                ),
                isActive: _currentStep == 0,
                  state: _currentStep > 0 ? StepState.complete : StepState.indexed
              ),
              Step(
                title: const Text('Plus'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: DropDownEnergie(onChanged: (String value) { selectedEnergie = value; }, onSelected: (String name) { selectedEnergieValue = name; },),),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    Row(
                      children: [
                        Expanded(child: DropDownPorte(onChanged: (String value) { selectedPorte = value; }, onSelected: (String name) { selectedPorteValue = name; },),),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    Row(
                      children: [
                        Expanded(child: DropDownPlace(onChanged: (String value) { selectedPlace = value; }, onSelected: (String name) { selectedPlaceValue = name; },),),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    Row(
                      children: [
                        Expanded(child: DropDownBoite(onChanged: (String value) { selectedBoite = value; }, onSelected: (String name) { selectedBoiteValue = name; },),),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    Row(
                      children: [
                        Expanded(child: DropDownCouleur(onChanged: (String value) { selectedCouleur = value; }, onSelected: (String name) { selectedCouleurValue = name; },),),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    Row(
                        children: [
                          SizedBox(
                            width: 250,
                            child: TextFormField(
                              controller: _descriptionController,
                              maxLines: 5,
                              validator: (value) => TValidator.validateEmptyText('Description', value),
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.document),
                                labelText: 'Description',
                              ),
                            ),
                          ),
                        ]
                    ),
                  ],
                ),
                isActive: _currentStep == 1,
                state: _currentStep > 1 ? StepState.complete : StepState.indexed
              ),
              Step(
                  title: const Text('Images'),
                  content: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
                      child: Column(
                        children: [
                          imageFileList.isEmpty ? const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    'Veuillez ajouter des images',
                                    style: TextStyle(
                                      fontSize: 16, // Vous pouvez ajuster la taille du texte selon vos besoins
                                      color: Colors.black, // Vous pouvez ajuster la couleur du texte selon vos besoins
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ) : const SizedBox.shrink(),
                          const SizedBox(height: TSizes.spaceBtwInputFields),
                          Row(
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
                                  child: GridView.builder(
                                      itemCount: imageFileList.length,
                                      shrinkWrap: true,
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 26,
                                        crossAxisSpacing: 26,
                                      ),
                                      itemBuilder: ((context, index) {
                                        return Stack(
                                          children: [
                                            Image.file(
                                              File(imageFileList[index].path),
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),
                                            Positioned(
                                              right: 0,
                                              child: IconButton(
                                                icon: const Icon(Icons.close),
                                                onPressed: () => removeImage(index),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                    ),

                                ),
                              ), /////////
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  isActive: _currentStep == 2,
                  state: _currentStep > 2 ? StepState.complete : StepState.indexed
              ),
              Step(
                title: const Text('Final'),
                content: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Row(
                          children: [
                            const Text('Marque'),
                            const SizedBox(width: 8.0),
                            Icon(
                              selectedModel?.marque.nomMarque.isEmpty ?? true ? Icons.close : Icons.check,
                              color: selectedModel?.marque.nomMarque.isEmpty ?? true ? Colors.red : Colors.green,
                            ),
                          ],
                        ),
                        titleTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                        subtitle: Text('${selectedModel?.marque.nomMarque}'),
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            const Text('Modele'),
                            const SizedBox(width: 8.0),
                            Icon(
                              selectedModeleValue.isEmpty ? Icons.close : Icons.check,
                              color: selectedModeleValue.isEmpty ? Colors.red : Colors.green,
                            ),
                          ],
                        ),
                        titleTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                        subtitle: Text(selectedModeleValue),
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            const Text('Categorie'),
                            const SizedBox(width: 8.0),
                            Icon(
                              selectedModel?.categorie.nomCategorie.isEmpty ?? true ? Icons.close : Icons.check,
                              color: selectedModel?.categorie.nomCategorie.isEmpty ?? true ? Colors.red : Colors.green,
                            ),
                          ],
                        ),
                        titleTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                        subtitle: Text('${selectedModel?.categorie.nomCategorie}'),
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            const Text('Porte'),
                            const SizedBox(width: 8.0),
                            Icon(
                              selectedPorteValue.isEmpty ? Icons.close : Icons.check,
                              color: selectedPorteValue.isEmpty ? Colors.red : Colors.green,
                            ),
                          ],
                        ),
                        titleTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                        subtitle: Text(selectedPorteValue),
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            const Text('Place'),
                            const SizedBox(width: 8.0),
                            Icon(
                              selectedPlaceValue.isEmpty ? Icons.close : Icons.check,
                              color: selectedPlaceValue.isEmpty ? Colors.red : Colors.green,
                            ),
                          ],
                        ),
                        titleTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                        subtitle: Text(selectedPlaceValue),
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            const Text('Kilometrage'),
                            const SizedBox(width: 8.0),
                            Icon(
                              _kilometrageController.text.isEmpty ? Icons.close : Icons.check,
                              color: _kilometrageController.text.isEmpty ? Colors.red : Colors.green,
                            ),
                          ],
                        ),
                        titleTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                        subtitle: Text('${_kilometrageController.text} km'),
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            const Text('Consommation(litres aux 100km)'),
                            const SizedBox(width: 8.0),
                            Icon(
                              _consommationController.text.isEmpty ? Icons.close : Icons.check,
                              color: _consommationController.text.isEmpty ? Colors.red : Colors.green,
                            ),
                          ],
                        ),
                        titleTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                        subtitle: Text(_consommationController.text),
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            const Text('Energie'),
                            const SizedBox(width: 8.0),
                            Icon(
                              selectedEnergieValue.isEmpty ? Icons.close : Icons.check,
                              color: selectedEnergieValue.isEmpty ? Colors.red : Colors.green,
                            ),
                          ],
                        ),
                        titleTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                        subtitle: Text(selectedEnergieValue),
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            const Text('Boite'),
                            const SizedBox(width: 8.0),
                            Icon(
                              selectedBoiteValue.isEmpty ? Icons.close : Icons.check,
                              color: selectedBoiteValue.isEmpty ? Colors.red : Colors.green,
                            ),
                          ],
                        ),
                        titleTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                        subtitle: Text(selectedBoiteValue),
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            const Text('Couleur'),
                            const SizedBox(width: 8.0),
                            Icon(
                              selectedCouleurValue.isEmpty ? Icons.close : Icons.check,
                              color: selectedCouleurValue.isEmpty ? Colors.red : Colors.green,
                            ),
                          ],
                        ),
                        titleTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                        subtitle: Text(selectedCouleurValue),
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            const Text('Ville'),
                            const SizedBox(width: 8.0),
                            Icon(
                              selectedVilleValue.isEmpty ? Icons.close : Icons.check,
                              color: selectedVilleValue.isEmpty ? Colors.red : Colors.green,
                            ),
                          ],
                        ),
                        titleTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                        subtitle: Text(selectedVilleValue),
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            const Text('Description'),
                            const SizedBox(width: 8.0),
                            Icon(
                              _descriptionController.text.isEmpty ? Icons.close : Icons.check,
                              color: _descriptionController.text.isEmpty ? Colors.red : Colors.green,
                            ),
                          ],
                        ),
                        titleTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                        subtitle: Text(_descriptionController.text),
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            const Text('Prix en Ariary'),
                            const SizedBox(width: 8.0),
                            Icon(
                              _prixController.text.isEmpty ? Icons.close : Icons.check,
                              color: _prixController.text.isEmpty ? Colors.red : Colors.green,
                            ),
                          ],
                        ),
                        titleTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                        subtitle: Text(_prixController.text),
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            const Text('Etat sur 10'),
                            const SizedBox(width: 8.0),
                            Icon(
                              selectedEtat.isEmpty ? Icons.close : Icons.check,
                              color: selectedEtat.isEmpty ? Colors.red : Colors.green,
                            ),
                          ],
                        ),
                        titleTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                        subtitle: Text(selectedEtat),
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            const Text('Images'),
                            const SizedBox(width: 8.0),
                            Icon(
                              imageFileList.isEmpty ? Icons.close : Icons.check,
                              color: imageFileList.isEmpty ? Colors.red : Colors.green,
                            ),
                          ],
                        ),
                        titleTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                        subtitle: Text('${imageFileList.length}'),
                      ),
                    ],
                  ),
                ),
                isActive: _currentStep == 3,
                state: _currentStep > 3 ? StepState.complete : StepState.indexed,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _currentStep == 2 ? FloatingActionButton(
        onPressed: selectMultipleImages,
        backgroundColor: TColors.primary,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        child: const Icon(Iconsax.add, color: Colors.white,),
      ) : null,
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomAppBar(
          color: Colors.white,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if(_currentStep != 0) IconButton(
                  onPressed: () {
                    if (_currentStep > 0) {
                      setState(() {
                        _currentStep -= 1;
                      });
                    }
                  },
                  icon : const Icon(Iconsax.arrow_left_24),
                ),
                _currentStep != 3 ? IconButton(
                  onPressed: () {
                    if (_currentStep < 3) {
                      setState(() {
                        _currentStep += 1;
                      });
                    }
                  },
                  icon : const Icon(Iconsax.arrow_right_34),
                ) : IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Nouvelle annonce'),
                          content: const Text('Êtes-vous sûr d\'ajouter cette annonce ?'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Annuler'),
                              onPressed: () {
                                Navigator.of(context).pop(); // Ferme le dialogue
                              },
                            ),
                            TextButton(
                              child: const Text('Confirmer'),
                              onPressed: () {
                                Navigator.of(context).pop(); // Ferme le dialogue
                                for (int i = 0; i < imageFileList.length; i++) {
                                  File imageFile = File(imageFileList[i].path);
                                  List<int> imageBytes = imageFile.readAsBytesSync();
                                  String base64Image = base64Encode(imageBytes);
                                  listBase64Image.add(base64Image);
                                }
                                // Valider les données du formulaire
                                if (_formKey.currentState!.validate()) {
                                  double prix = double.parse(_prixController.text);
                                  int idCategorie = int.parse(selectedModel!.categorie.idCategorie.toString());
                                  int idMarque = int.parse(selectedModel!.marque.idMarque.toString());
                                  int idModele = int.parse(selectedModele);
                                  int idEnergie = int.parse(selectedEnergie);
                                  int idBoite = int.parse(selectedBoite);
                                  double consommation = double.parse(_consommationController.text);
                                  int idPorte = int.parse(selectedPorte);
                                  double kilometrage = double.parse(_kilometrageController.text);
                                  int idCouleur = int.parse(selectedCouleur);
                                  int etat = int.parse(selectedEtat);
                                  int idPlace = int.parse(selectedPlace);
                                  int idVille = int.parse(selectedVille);
                                  String description = _descriptionController.text;
                                  //sendImage with base64

                                  if(selectedModele == "" || selectedPorte == "" || selectedPlace == "" || _kilometrageController.text == "" || _consommationController.text == "" || selectedEnergie == "" || selectedBoite == "" || selectedCouleur == "" || selectedVille == "" || _descriptionController.text == "" || _prixController.text == "" || selectedEtat == "") {
                                    TLoaders.errorSnackBar(title: "Information", message: 'Veuillez remplir toutes les informations');
                                    return;
                                  }
                                  if(imageFileList.isEmpty) {
                                    TLoaders.errorSnackBar(title: "Information", message: 'Veuillez ajouter au moins une image');
                                    return;
                                  }
                                  AnnonceController annonceController = Get.find();
                                  annonceController.createAnnonce(prix, idCategorie, idMarque, idModele, idEnergie, idBoite, consommation, idPorte, kilometrage, idCouleur, etat, idPlace, idVille, description, listBase64Image);
                                  TLoaders.successSnackBar(title: "Information", message: 'Publication en cours');
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon : const Icon(Iconsax.send_2),
                )
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}