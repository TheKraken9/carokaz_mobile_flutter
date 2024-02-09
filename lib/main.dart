import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:mada_jeune/bindings/general_bindings.dart';
import 'package:mada_jeune/commons/widgets/loaders/loaders.dart';
import 'package:mada_jeune/data/models/utilisateur/utilisateur_model.dart';
import 'package:mada_jeune/data/repositories/authentication/authentication_repository.dart';
import 'package:mada_jeune/data/services/annonce/annonce_service.dart';
import 'package:mada_jeune/data/services/boite/boite_service.dart';
import 'package:mada_jeune/data/services/categorie/categorie_service.dart';
import 'package:mada_jeune/data/services/couleur/couleur_service.dart';
import 'package:mada_jeune/data/services/energie/energie_service.dart';
import 'package:mada_jeune/data/services/marque/marque_service.dart';
import 'package:mada_jeune/data/services/model/model_service.dart';
import 'package:mada_jeune/data/services/place/place_service.dart';
import 'package:mada_jeune/data/services/porte/porte_service.dart';
import 'package:mada_jeune/data/services/utilisateur/utilisateur_service.dart';
import 'package:mada_jeune/data/services/ville/ville_service.dart';
import 'package:mada_jeune/features/authentication/controller/annonce/annonce_controller.dart';
import 'package:mada_jeune/features/authentication/controller/connected_user/connected_user_controller.dart';
import 'package:mada_jeune/features/authentication/controller/login/login_controller.dart';
import 'package:mada_jeune/features/authentication/controller/signup/signup_controller.dart';
import 'package:mada_jeune/features/authentication/screens/login/login.dart';
import 'package:mada_jeune/features/authentication/screens/onboarding/onboarding.dart';
import 'package:mada_jeune/features/authentication/screens/signup/signup.dart';
import 'package:mada_jeune/features/shop/screens/wishlist/wishlist.dart';
import 'package:mada_jeune/navigation_menu.dart';
import 'package:mada_jeune/utils/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'firebase_options.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => MarqueService());
  GetIt.I.registerLazySingleton(() => ModelService());
  GetIt.I.registerLazySingleton(() => CategorieService());
  GetIt.I.registerLazySingleton(() => PorteService());
  GetIt.I.registerLazySingleton(() => PlaceService());
  GetIt.I.registerLazySingleton(() => EnergieService());
  GetIt.I.registerLazySingleton(() => BoiteService());
  GetIt.I.registerLazySingleton(() => CouleurService());
  GetIt.I.registerLazySingleton(() => VilleService());
  GetIt.I.registerLazySingleton(() => AnnonceService());
  GetIt.I.registerLazySingleton(() => UtilisateurService());
  GetIt.I.registerLazySingleton(() => AnnonceController());
}

var uuid = const Uuid();
int id = uuid.v1().hashCode;

triggerNotification(String title, String body) {
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: 'basic_channel',
      title: title,
      body: body,
      bigPicture: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
      notificationLayout: NotificationLayout.Default,
      largeIcon: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'
    ),
  );
}

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };
  }
}

Future<void> main() async {
  HttpOverrides.global = PostHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AwesomeNotifications().initialize(
    'resource://drawable/splash',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: const Color(0xFF1E3FE1),
        ledColor: Colors.white,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        locked: false,
        playSound: false,
        enableVibration: true,
        vibrationPattern: mediumVibrationPattern,
        defaultRingtoneType: DefaultRingtoneType.Notification,
      )
    ],
    debug: true,
  );

  final String? tk = await FirebaseMessaging.instance.getToken();
  debugPrint("Token mobile: $tk");

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      if (kDebugMode) {
        print('Message title: ${notification.title}');
        print('Message body: ${notification.body}');
      }
      if(notification.title != null && notification.body != null) {
        triggerNotification(notification.title!, notification.body!);
      }
    }
  });
  //await Firebase.initializeApp();

  //const storage = FlutterSecureStorage();
  /*await storage.write(
      key: 'bearer',
      value: "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJqZWFuQGdtYWlsLmNvbSIsImlhdCI6MTcwNjIwNDM4NCwiZXhwIjoxNzA2MjkwNzg0fQ.dnvao7udeRCpfRT8S3yRXmCfR-FarPkxctAqZNIEQTo");

   */
  //final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //await storage.write(key: 'idUtilisateur', value: 'USR1');
  const storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'bearer');
  if (kDebugMode) {
    print(token);
  }

  ConnectedUserController connectedUserController = Get.put(ConnectedUserController());
  if (token != null) {
    UtilisateurModel? utilisateurModel = (await connectedUserController.getIdUserConnected()).data;
    if(utilisateurModel?.idUtilisateur == null){
      setupLocator();
      TLoaders.errorSnackBar(
        title: 'Erreur',
        message: 'Vous devez vous reconnecter pour continuer',
      );
      runApp(const MyApp());
    }else {
      late SharedPreferences prefs;
      prefs = await SharedPreferences.getInstance();
      prefs.setString('idUtilisateur', utilisateurModel!.idUtilisateur);
      prefs.setString('email', utilisateurModel.mail);
      setupLocator();
      runApp(const HomeApp());
    }
  }else{
    setupLocator();
    runApp(const MyApp());
  }


  //await GetStorage.init();

  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((FirebaseApp value) => Get.put(AuthenticationRepository()));
}

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    final SignupController signupController = Get.put(SignupController());

    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      debugShowCheckedModeBanner: false,
      home: const HomeAppPage(),
      routes: {
        '/home' : (context) => const NavigationMenu(),
        '/login' : (context) => const LoginScreen(),
        '/signup' : (context) => const SignupScreen(),
        '/ventes' : (context) => const FavoriteScreen(),
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    final SignupController signupController = Get.put(SignupController());

    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        '/home' : (context) => const NavigationMenu(),
        '/login' : (context) => const LoginScreen(),
        '/signup' : (context) => const SignupScreen(),
        '/ventes' : (context) => const FavoriteScreen(),
      },
    );
  }
}


class HomeAppPage extends StatefulWidget {
  const HomeAppPage({super.key});

  @override
  _HomeAppPageState createState() => _HomeAppPageState();
}

class _HomeAppPageState extends State<HomeAppPage> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/animations/Animation4.json',
                controller: _controller, onLoaded: (composition) {
                  _controller
                    ..duration = composition.duration
                    ..forward().then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NavigationMenu()),
                      );
                    });
                }
            ),
            const Center(
              child: Text(
                'Car\'Okaz',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontFamily: 'Poppins'
                ),
              ),
            ),
            const Text(
              'Made in Gasikara',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.normal ,
                  color: Colors.black,
                  fontFamily: 'Poppins'
              ),
            ),
          ],
        )
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
   _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/animations/Animation4.json',
            controller: _controller, onLoaded: (composition) {
            _controller
              ..duration = composition.duration
              ..forward().then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
                );
              });
            }
          ),
          const Center(
            child: Text(
              'Car\'Okaz',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontFamily: 'Poppins'
              ),
            ),
          ),
            const Text(
              'Made in Gasikara',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.normal ,
                color: Colors.black,
                fontFamily: 'Poppins'
              ),
            ),
        ],
      )
    );
  }
}

