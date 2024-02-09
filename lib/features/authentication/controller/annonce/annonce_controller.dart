import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mada_jeune/commons/widgets/loaders/loaders.dart';
import 'package:mada_jeune/data/models/annonce/annonce_model.dart';
import 'package:mada_jeune/data/models/api_response.dart';

class AnnonceController extends GetxController {
  static AnnonceController get instance => Get.find();
  final storage = const FlutterSecureStorage();
  final date_ajourdhui_sans_time = DateTime.now().toString().substring(0, 10);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> createAnnonce(double prix, int idCategorie, int idMarque, int idModele, int idEnergie, int idBoite, double consommation, int idPorte, double kilometrage, int idCouleur, int etat, int idPlace, int idVille, String description, List<String> photo) async{
    String? token = await storage.read(key: "bearer");
    const baseurl = 'https://test-production-3fbf.up.railway.app';
    List<String> listPhoto = photo.toList();
    final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
    HttpClient client = HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = IOClient(client);
      final response = await ioClient.post(
          Uri.parse('$baseurl/annonces'),
          headers: headers,
        body: jsonEncode(<String, dynamic>{
          "dateAnnonce": date_ajourdhui_sans_time,
          "prix": prix,
          "voiture": {
            "categorie": {
              "idCategorie": idCategorie
            },
            "marque": {
              "idMarque": idMarque
            },
            "modele": {
              "idModele": idModele
            },
            "energie": {
              "idEnergie": idEnergie
            },
            "boite": {
              "idBoite": idBoite
            },
            "consommation": consommation,
            "place": {
              "idPlace": idPlace
            },
            "porte": {
              "idPorte": idPorte
            },
            "kilometrage": kilometrage,
            "couleur": {
              "idCouleur": idCouleur
            },
            "etat": etat,
          },
          "ville": {
            "idVille": idVille
          },
          "description": description,
          "etat": 0,
          "photo": [
            for (var i = 0; i < listPhoto.length; i++)
              {"photo": photo[i]},
          ]
        }),
      );
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 201) {
      TLoaders.successSnackBar(title: 'Annonce', message: 'Votre annonce a ete creee avec succes');
      if (kDebugMode) {
        print("success");
      }
      Get.offAllNamed('/ventes');
    } else {
      TLoaders.errorSnackBar(title: 'Erreur', message: 'Veuillez verifier vos donnees');
      if (kDebugMode) {
        print("error");
      }
    }
  }
}