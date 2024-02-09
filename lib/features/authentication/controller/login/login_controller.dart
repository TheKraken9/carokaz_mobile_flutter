import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:http/io_client.dart';
import 'package:mada_jeune/commons/widgets/loaders/loaders.dart';
import 'package:mada_jeune/data/models/utilisateur/utilisateur_model.dart';
import 'package:mada_jeune/features/authentication/controller/connected_user/connected_user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  static const baseurl = 'https://test-production-3fbf.up.railway.app';
  final storage = const FlutterSecureStorage();
  Future<String?> login(String email, String password) async {
  HttpClient client = HttpClient()
    ..badCertificateCallback =
    ((X509Certificate cert, String host, int port) => true);
  IOClient ioClient = IOClient(client);
    final response = await ioClient.post(
      Uri.parse('$baseurl/auth/signin'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "email": email,
        "password": password
      }),
    );
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      TLoaders.successSnackBar(
        title: 'Connexion réussie',
        message: 'Vous êtes connecté avec succès',
      );
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      final token = jsonData['token'] as String;
      await storage.write(key: 'bearer', value: token);

      ConnectedUserController connectedUserController = Get.put(ConnectedUserController());
      UtilisateurModel utilisateurModel = (await connectedUserController.getIdUserConnected()).data!;
      if (kDebugMode) {
        print(utilisateurModel.idUtilisateur);
        print(utilisateurModel.mail);
      }
      //store on Preferences
      late SharedPreferences prefs;
      prefs = await SharedPreferences.getInstance();
      prefs.setString('idUtilisateur', utilisateurModel.idUtilisateur);
      prefs.setString('email', utilisateurModel.mail);

      // Après que l'utilisateur s'est connecté avec succès, obtenez le token FCM et envoyez-le au serveur
      sendTokenToServer(utilisateurModel.idUtilisateur, await storage.read(key: 'bearer'));

      if (kDebugMode) {
        print(token);
      }
      Get.offAllNamed('/home');
      return token;
    } else {
      TLoaders.errorSnackBar(
        title: 'Erreur de connexion',
        message: 'Veuillez vérifier vos identifiants',
      );
      return null;
    }
  }

  Future<void> sendTokenToServer(String idUtilisateur, String? bearer) async {
    final String? tk = await FirebaseMessaging.instance.getToken();
    HttpClient client = HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = IOClient(client);
    final response = await ioClient.post(
      Uri.parse('$baseurl/mobiles'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $bearer'
      },
      body: jsonEncode(<String, String>{
        "idUtilisateur": idUtilisateur,
        "token": tk!
      }),
    );
  }
}