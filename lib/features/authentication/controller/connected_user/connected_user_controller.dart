import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:mada_jeune/data/models/api_response.dart';
import 'package:mada_jeune/data/models/utilisateur/utilisateur_model.dart';

class ConnectedUserController {
  static const baseurl = 'https://test-production-3fbf.up.railway.app';
  final storage = const FlutterSecureStorage();

  Future<APIResponse<UtilisateurModel>> getIdUserConnected() async {

    String? token = await storage.read(key: "bearer");

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    HttpClient client = HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = IOClient(client);
    final response = await ioClient.get(Uri.parse('$baseurl/utilisateurs/connecte'), headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (kDebugMode) {
        //print(jsonData);
      }
      // Accédez à l'objet "data" dans la réponse JSON
      final data = jsonData['data'];

      // Mappez les objets JSON en objets MarqueModel
      final utilisateur = UtilisateurModel.fromJson(data);

      // Retournez une APIResponse avec les données des marques
      return APIResponse<UtilisateurModel>(data: utilisateur);
    } else {
      // Gérer les erreurs HTTP ici
      return APIResponse<UtilisateurModel>(
        erreur: "Erreur HTTP: ${response.statusCode}",
        remarque: "Erreur HTTP",
        data: null,
      );
    }
  }
}