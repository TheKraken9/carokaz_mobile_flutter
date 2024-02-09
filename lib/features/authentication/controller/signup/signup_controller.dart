import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/io_client.dart';
import 'package:mada_jeune/commons/widgets/loaders/loaders.dart';
import 'package:mada_jeune/data/repositories/authentication/authentication_repository.dart';
import 'package:mada_jeune/utils/constants/image_strings.dart';
import 'package:mada_jeune/utils/network/network_manager.dart';
import 'package:mada_jeune/utils/popups/full_screen_loader.dart';
import 'package:http/http.dart' as http;

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final nom = TextEditingController();
  final prenom = TextEditingController();
  final adresse = TextEditingController();
  final contact = TextEditingController();
  final mail = TextEditingController();
  final password = TextEditingController();
  final ville = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void signup() async {
    try {
      TFullScreenLoader.openLoadingDialog('Création de compte', TImages.audi);

      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        return;
      }

      if(!_formKey.currentState!.validate()) {
        return;
      }

      if(!privacyPolicy.value) {
        TLoaders.warningSnackBar(
          title: 'j\'accepte les conditions d\'utilisation',
          message: 'Veuillez accepter les conditions d\'utilisation',
        );
        return;
      }

      //final userCredential =  await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

    }catch(e) {
      TLoaders.errorSnackBar(title: 'Oh lala', message: e.toString());
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }

  Future<void> createUser(String nom, String prenom, String id_ville, String adresse, String contact, String email, String password) async {
    const baseurl = 'https://test-production-3fbf.up.railway.app';

    if (kDebugMode) {
      print(nom);
    }

    HttpClient client = HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = IOClient(client);
    final response = await ioClient.post(
      Uri.parse('$baseurl/auth/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "firstName": nom,
        "lastName": prenom,
        "id_ville": id_ville,
        "adresse": adresse,
        "contact": contact,
        "email": email,
        "password": password,
        "role":0
      }),
    );
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("success");
      }
      Get.offAllNamed('/login');
    } else {
      if (kDebugMode) {
        print("error");
      }
    }
  }
}