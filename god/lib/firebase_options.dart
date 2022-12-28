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
    apiKey: 'AIzaSyDAVvhwE2ePmrou2VEIktEGMxoy3yL7CpE',
    appId: '1:915436994762:web:96f3bfb07ee7998fc33433',
    messagingSenderId: '915436994762',
    projectId: 'godd-98ae9',
    authDomain: 'godd-98ae9.firebaseapp.com',
    storageBucket: 'godd-98ae9.appspot.com',
    measurementId: 'G-5CZXZ72E60',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyALpc8I5iqMQLsNLDWUkNpN1MHTm4ZfGbY',
    appId: '1:915436994762:android:08b6977a4c011463c33433',
    messagingSenderId: '915436994762',
    projectId: 'godd-98ae9',
    storageBucket: 'godd-98ae9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAmuzBQ1U5-rTyTX-PUSWLDSWjjaJAXFw0',
    appId: '1:915436994762:ios:d0a6e347bdcd6a4ac33433',
    messagingSenderId: '915436994762',
    projectId: 'godd-98ae9',
    storageBucket: 'godd-98ae9.appspot.com',
    iosClientId: '915436994762-r5gn6lgbonajuckuvhi9k065etfeddgd.apps.googleusercontent.com',
    iosBundleId: 'com.example.god',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAmuzBQ1U5-rTyTX-PUSWLDSWjjaJAXFw0',
    appId: '1:915436994762:ios:d0a6e347bdcd6a4ac33433',
    messagingSenderId: '915436994762',
    projectId: 'godd-98ae9',
    storageBucket: 'godd-98ae9.appspot.com',
    iosClientId: '915436994762-r5gn6lgbonajuckuvhi9k065etfeddgd.apps.googleusercontent.com',
    iosBundleId: 'com.example.god',
  );
}