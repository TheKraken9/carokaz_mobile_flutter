import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/io_client.dart';
import 'package:mada_jeune/data/models/api_response.dart';
import 'package:mada_jeune/data/models/ville/ville_model.dart';
import 'package:http/http.dart' as http;

class VilleService {

  static const baseurl = 'https://test-production-3fbf.up.railway.app';
  final storage = const FlutterSecureStorage();

  Future<APIResponse<List<VilleModel>>> getAllVille() async {
    HttpClient client = HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = IOClient(client);

    String? token = await storage.read(key: "bearer");
    final headers = {
      'Content-Type': 'application/json'
    };
    final response = await ioClient.get(Uri.parse('$baseurl/villes'), headers: headers);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as Map<String, dynamic>;

      // Accédez à l'objet "data" dans la réponse JSON
      final data = jsonData['data'] as List<dynamic>;

      // Mappez les objets JSON en objets VilleModel
      final marques = data.map((item) => VilleModel.fromJson(item)).toList();

      // Retournez une APIResponse avec les données des marques
      return APIResponse<List<VilleModel>>(data: marques);
    } else {
      // Gérer les erreurs HTTP ici
      return APIResponse<List<VilleModel>>(
        erreur: "Erreur HTTP: ${response.statusCode}",
        remarque: "Erreur HTTP",
        data: null,
      );
    }
  }
}