// ignore_for_file: prefer_const_constructors

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quickshop_ecommerce/providers/product_bloc.dart';
import 'package:quickshop_ecommerce/providers/auth.dart';
import 'package:quickshop_ecommerce/providers/search_bloc.dart';
import 'package:quickshop_ecommerce/screens/home_page.dart';
import 'package:quickshop_ecommerce/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quickshop_ecommerce/screens/splash.dart';
import 'firebase_options.dart';
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Directory directory = await getApplicationDocumentsDirectory();
  // Hive.init(directory.path);
  // await Hive.openBox(Constants.bookmarkTag);
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
        ChangeNotifierProvider<FirebaseAuthBloc>(
            create: (context) => FirebaseAuthBloc()),
        ChangeNotifierProvider<SearchBloc>(create: (context) => SearchBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-Commerce App',
        theme: themeData,
        home: StreamBuilder(
          stream: FirebaseAuthBloc().getAuthChange,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return SplashPage();
            }
          },
        ),
      ),
    );
  }
}
