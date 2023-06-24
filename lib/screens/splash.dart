// ignore_for_file: prefer_const_constructors

import 'package:e_commerce_app/constants/asset_image.dart';
import 'package:e_commerce_app/screens/Welcome_page.dart';
import 'package:e_commerce_app/utils/nextscreen.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future _afterSplash() async {
    Future.delayed(const Duration(milliseconds: 1500))
        .then((value) => nextScreenReplace(context, const WelcomePage()));
  }

  @override
  void initState() {
    _afterSplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image(
        height: 200,
        width: 200,
        image: AssetImage(AssetImages.instance.welcomeImgae),
      )),
    );
  }
}
