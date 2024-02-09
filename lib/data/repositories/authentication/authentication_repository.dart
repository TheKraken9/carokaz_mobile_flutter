import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mada_jeune/features/authentication/screens/login/login.dart';
import 'package:mada_jeune/features/authentication/screens/onboarding/onboarding.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();
  // final _auth = FirebaseAuth.instance;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screeRedirect();
  }

  screeRedirect() async{
    if(kDebugMode) {
      print('============== GET STORAGE  Auth repo ================');
      print(deviceStorage.read('IsFirstTime'));
    }
    deviceStorage.writeIfNull('IsFirstTime', true);
    deviceStorage.read('IsFirstTime') != true
        ? Get.offAll(() => const OnBoardingScreen())
        : Get.offAll(const OnBoardingScreen());
  }

  /*Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch(e) {
      throw TFormatException(e.message).message;
    } on PlatformException catch(e) {
      throw TPlatformException(e.message.toString()).message;
    } catch(e) {
      throw 'Une erreur inconnue s\'est produite';
    }
  }*/
}