// ignore_for_file: prefer_const_constructors

import 'package:e_commerce_app/firebase_helper/auth.dart';
import 'package:e_commerce_app/screens/home.dart';
import 'package:e_commerce_app/screens/splash.dart';
import 'package:e_commerce_app/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      theme: themeData,
      home: StreamBuilder(
        stream: FirebaseAuthHelper.instatnce.getAuthChange,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // TODO: return Homepage();
            return Homepage();
          } else {
            return Homepage();
          }
        },
      ),
    );
  }
}
