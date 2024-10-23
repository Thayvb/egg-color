import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyD8keIdpowos40SFqDtE7ZlYxnS2ulwb-8",
            authDomain: "tccegs.firebaseapp.com",
            projectId: "tccegs",
            storageBucket: "tccegs.appspot.com",
            messagingSenderId: "629556831805",
            appId: "1:629556831805:web:38448072547823410f6c54",
            measurementId: "G-8XV4K3JJEG"));
  } else {
    await Firebase.initializeApp();
  }
}
