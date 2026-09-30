import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAS9774wTDKlfcY2vs_vz4pW0aNYTO4XaA",
            authDomain: "tarjetasjela.firebaseapp.com",
            projectId: "tarjetasjela",
            storageBucket: "tarjetasjela.firebasestorage.app",
            messagingSenderId: "267134015934",
            appId: "1:267134015934:web:d55f6fb953294fe1c581ef",
            measurementId: "G-8HSKGWCYFN"));
  } else {
    await Firebase.initializeApp();
  }
}
