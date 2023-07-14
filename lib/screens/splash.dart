// ignore_for_file: prefer_const_constructors

import 'package:quickshop_ecommerce/constants/asset_image.dart';
import 'package:quickshop_ecommerce/screens/Welcome_page.dart';
import 'package:quickshop_ecommerce/utils/nextscreen.dart';
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
        height: 100,
        width: 100,
        image: AssetImage(AssetImages.instance.logo),
      )),
    );
  }
}
