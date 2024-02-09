import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/io_client.dart';
import 'package:mada_jeune/data/models/api_response.dart';
import 'package:mada_jeune/data/models/couleur/couleur_model.dart';
import 'package:http/http.dart' as http;

class CouleurService {

  static const baseurl = 'https://test-production-3fbf.up.railway.app';
  final storage = const FlutterSecureStorage();

  Future<APIResponse<List<CouleurModel>>> getAllCouleur() async {
    String? token = await storage.read(key: "bearer");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    HttpClient client = HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = IOClient(client);
    final response = await ioClient.get(Uri.parse('$baseurl/couleurs'), headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as Map<String, dynamic>;

      // Accédez à l'objet "data" dans la réponse JSON
      final data = jsonData['data'] as List<dynamic>;

      // Mappez les objets JSON en objets CouleurModel
      final couleurs = data.map((item) => CouleurModel.fromJson(item)).toList();

      // Retournez une APIResponse avec les données des marques
      return APIResponse<List<CouleurModel>>(data: couleurs);
    } else {
      // Gérer les erreurs HTTP ici
      return APIResponse<List<CouleurModel>>(
        erreur: "Erreur HTTP: ${response.statusCode}",
        remarque: "Erreur HTTP",
        data: null,
      );
    }
  }

}