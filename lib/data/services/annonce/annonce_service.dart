import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/io_client.dart';
import 'package:mada_jeune/commons/widgets/loaders/loaders.dart';
import 'package:mada_jeune/data/models/annonce/annonce_model.dart';
import 'package:mada_jeune/data/models/api_response.dart';
import 'package:http/http.dart' as http;


class AnnonceService {

  static const baseurl = 'https://test-production-3fbf.up.railway.app';
  final storage = const FlutterSecureStorage();

  Future<APIResponse<List<AnnonceModel>>> getAllAnnonce(String? idUtilisateur) async {
    String? token = await storage.read(key: "bearer");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    HttpClient client = HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = IOClient(client);

    final response = await ioClient.get(Uri.parse('$baseurl/annonces/utilisateur/$idUtilisateur'), headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      if (kDebugMode) {
        //print(jsonData);
      }
      // Accédez à l'objet "data" dans la réponse JSON
      final data = jsonData['data'] as List<dynamic>;
      if (kDebugMode) {
        print("taille : ${data.length}");
      }

      // Mappez les objets JSON en objets MarqueModel
      final marques = data.map((item) => AnnonceModel.fromJson(item)).toList();

      // Retournez une APIResponse avec les données des marques
      return APIResponse<List<AnnonceModel>>(data: marques);
    } else {
      // Gérer les erreurs HTTP ici
      return APIResponse<List<AnnonceModel>>(
        erreur: "Erreur HTTP: ${response.statusCode}",
        remarque: "Erreur HTTP",
        data: null,
      );
    }
  }
  
  Future<APIResponse<AnnonceModel>> updateEtatAnnonce(String idAnnonce) async {
    String? token = await storage.read(key: "bearer");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await http.put(Uri.parse('$baseurl/annonces/vendre/$idAnnonce'), headers: headers);

    if (response.statusCode == 200) {
      TLoaders.successSnackBar(
        title: 'Annonce',
        message: 'Annonce marquée comme vendue avec succès',
      );
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      if (kDebugMode) {
        //print(jsonData);
      }
      // Accédez à l'objet "data" dans la réponse JSON
      final data = jsonData['data'];

      // Mappez les objets JSON en objets MarqueModel
      final marques = AnnonceModel.fromJson(data);
      if (kDebugMode) {
        print("ok");
      }

      // Retournez une APIResponse avec les données des marques
      return APIResponse<AnnonceModel>(data: marques);
    } else {
      // Gérer les erreurs HTTP ici
      TLoaders.errorSnackBar(
        title: 'Annonce',
        message: 'Erreur lors de la mise à jour de l\'annonce',
      );
      return APIResponse<AnnonceModel>(
        erreur: "Erreur HTTP: ${response.statusCode}",
        remarque: "Erreur HTTP",
        data: null,
      );
    }
  }

  Future<APIResponse<AnnonceModel>> deleteAnnonce(String idAnnonce) async {
    String? token = await storage.read(key: "bearer");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await http.put(Uri.parse('$baseurl/annonces/annuler/$idAnnonce'), headers: headers);

    if (response.statusCode == 200) {
      TLoaders.successSnackBar(
        title: 'Annonce',
        message: 'Annonce annulée avec succès',
      );
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      if (kDebugMode) {
        //print(jsonData);
      }
      // Accédez à l'objet "data" dans la réponse JSON
      final data = jsonData['data'];

      // Mappez les objets JSON en objets MarqueModel
      final marques = AnnonceModel.fromJson(data);
      if (kDebugMode) {
        print("ok");
      }

      // Retournez une APIResponse avec les données des marques
      return APIResponse<AnnonceModel>(data: marques);
    } else {
      TLoaders.errorSnackBar(
        title: 'Annonce',
        message: 'Erreur lors de la suppression de l\'annonce',
      );
      // Gérer les erreurs HTTP ici
      return APIResponse<AnnonceModel>(
        erreur: "Erreur HTTP: ${response.statusCode}",
        remarque: "Erreur HTTP",
        data: null,
      );
    }
  }

  Future<APIResponse<AnnonceModel>> reUpdateEtatAnnonce(String idAnnonce) async {
    String? token = await storage.read(key: "bearer");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await http.put(Uri.parse('$baseurl/annonces/confirmer/$idAnnonce'), headers: headers);

    if (response.statusCode == 200) {
      TLoaders.successSnackBar(
        title: 'Annonce',
        message: 'Annonce remise en vente avec succès',
      );
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      if (kDebugMode) {
        //print(jsonData);
      }
      // Accédez à l'objet "data" dans la réponse JSON
      final data = jsonData['data'];

      // Mappez les objets JSON en objets MarqueModel
      final marques = AnnonceModel.fromJson(data);
      if (kDebugMode) {
        print("ok");
      }

      // Retournez une APIResponse avec les données des marques
      return APIResponse<AnnonceModel>(data: marques);
    } else {
      TLoaders.errorSnackBar(
        title: 'Annonce',
        message: 'Erreur lors de la mise à jour de l\'annonce',
      );
      // Gérer les erreurs HTTP ici
      return APIResponse<AnnonceModel>(
        erreur: "Erreur HTTP: ${response.statusCode}",
        remarque: "Erreur HTTP",
        data: null,
      );
    }
  }

}