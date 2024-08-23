// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyD-H-g1lwuZcGp50Vy2Z151qwszl7pvnpo',
    appId: '1:19508386122:web:fee8bd6c9a6a2ecd5209b3',
    messagingSenderId: '19508386122',
    projectId: 'software-lab-ab027',
    authDomain: 'software-lab-ab027.firebaseapp.com',
    storageBucket: 'software-lab-ab027.appspot.com',
    measurementId: 'G-XJ94K7JMZS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCBGmUybZLivEKs0dGi1dXSV7Okx4S7tfA',
    appId: '1:19508386122:android:9d06d812a9b82c9e5209b3',
    messagingSenderId: '19508386122',
    projectId: 'software-lab-ab027',
    storageBucket: 'software-lab-ab027.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAEmHLrFyjT7hB8MMVNzs37woo-AUmdwZs',
    appId: '1:19508386122:ios:1935d50930a578c85209b3',
    messagingSenderId: '19508386122',
    projectId: 'software-lab-ab027',
    storageBucket: 'software-lab-ab027.appspot.com',
    iosBundleId: 'com.example.softwareLabAssignment',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAEmHLrFyjT7hB8MMVNzs37woo-AUmdwZs',
    appId: '1:19508386122:ios:1935d50930a578c85209b3',
    messagingSenderId: '19508386122',
    projectId: 'software-lab-ab027',
    storageBucket: 'software-lab-ab027.appspot.com',
    iosBundleId: 'com.example.softwareLabAssignment',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD-H-g1lwuZcGp50Vy2Z151qwszl7pvnpo',
    appId: '1:19508386122:web:da87c3a1f44386585209b3',
    messagingSenderId: '19508386122',
    projectId: 'software-lab-ab027',
    authDomain: 'software-lab-ab027.firebaseapp.com',
    storageBucket: 'software-lab-ab027.appspot.com',
    measurementId: 'G-0J19F9G4D5',
  );
}
