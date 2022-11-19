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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCCx8uKz1wd6Gv4rlhjNEZisuEEPchII6o',
    appId: '1:408553028507:web:bdcfa0b457eb22323e7f3e',
    messagingSenderId: '408553028507',
    projectId: 'my-instagramconeagain-project',
    authDomain: 'my-instagramconeagain-project.firebaseapp.com',
    storageBucket: 'my-instagramconeagain-project.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAI_-nFvbx4SBJ6HAaoapWxmIAZ2QN9oMM',
    appId: '1:408553028507:android:f1cb0dc88aa0dc243e7f3e',
    messagingSenderId: '408553028507',
    projectId: 'my-instagramconeagain-project',
    storageBucket: 'my-instagramconeagain-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCZDvag0QB61mmpCG6W61OxOR1y2QA6GDg',
    appId: '1:408553028507:ios:b69c872202ebef483e7f3e',
    messagingSenderId: '408553028507',
    projectId: 'my-instagramconeagain-project',
    storageBucket: 'my-instagramconeagain-project.appspot.com',
    iosClientId: '408553028507-8s9ih5oocu1rvrteimmmp0dr7p8qqi0e.apps.googleusercontent.com',
    iosBundleId: 'com.example.instagramcloneapp',
  );
}
