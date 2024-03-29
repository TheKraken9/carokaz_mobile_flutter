// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC08Sxkz7YmjJq3nZYwrCWAPYOK-w5Rp5w',
    appId: '1:82431486151:web:83721a43b0317ef156f6e2',
    messagingSenderId: '82431486151',
    projectId: 'notificationclouds5',
    authDomain: 'notificationclouds5.firebaseapp.com',
    storageBucket: 'notificationclouds5.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAhOMFOvd-sDzoplu7BynuejA1XxnEhr-4',
    appId: '1:82431486151:android:c76ca1d7e1f4900456f6e2',
    messagingSenderId: '82431486151',
    projectId: 'notificationclouds5',
    storageBucket: 'notificationclouds5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCQx743UOvSri2pI1g3E4ra5qTVzm2RZtg',
    appId: '1:82431486151:ios:ec1de60b92bdb3b356f6e2',
    messagingSenderId: '82431486151',
    projectId: 'notificationclouds5',
    storageBucket: 'notificationclouds5.appspot.com',
    iosBundleId: 'com.stackx.madaJeune',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCQx743UOvSri2pI1g3E4ra5qTVzm2RZtg',
    appId: '1:82431486151:ios:2abe26290f4f60e656f6e2',
    messagingSenderId: '82431486151',
    projectId: 'notificationclouds5',
    storageBucket: 'notificationclouds5.appspot.com',
    iosBundleId: 'com.stackx.madaJeune.RunnerTests',
  );
}
