import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutController {

  final storage = const FlutterSecureStorage();
  late SharedPreferences prefs;

  void logout() async{
    await storage.delete(key: 'bearer');
    prefs = await SharedPreferences.getInstance();
    prefs.remove('idUtilisateur');
    prefs.remove('email');
  }
}