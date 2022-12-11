import 'package:auth/pages/homePage.dart';
import 'package:auth/pages/login.dart';
import 'package:auth/pages/signUp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => const loginPage(),
      '/home': (context) => const homePage(),
      '/register': (context) => const signUp(),
  },
    initialRoute: '/',
  ));
}


