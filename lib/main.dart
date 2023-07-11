// ignore_for_file: prefer_const_constructors

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quickshop_ecommerce/blocs/product_bloc.dart';
import 'package:quickshop_ecommerce/firebase_helper/auth.dart';
import 'package:quickshop_ecommerce/screens/checkout.dart';
import 'package:quickshop_ecommerce/screens/home_page.dart';
import 'package:quickshop_ecommerce/screens/splash.dart';
import 'package:quickshop_ecommerce/screens/welcome_page.dart';
import 'package:quickshop_ecommerce/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductBloc>(create: (context) => ProductBloc()),
        ChangeNotifierProvider<FirebaseAuthHelper>(
            create: (context) => FirebaseAuthHelper()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-Commerce App',
        theme: themeData,
        home: StreamBuilder(
          stream: FirebaseAuthHelper().getAuthChange,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // TODO: return Homepage();
              return HomePage();
            } else {
              return WelcomePage();
            }
          },
        ),
      ),
    );
  }
}
