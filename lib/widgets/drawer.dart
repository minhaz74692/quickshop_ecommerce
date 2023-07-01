// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quickshop_ecommerce/screens/home_page.dart';
import 'package:quickshop_ecommerce/utils/nextscreen.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  // TODO: Complete Drawer Widget
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Center(
        child: ElevatedButton(
          child: Text('NavBar'),
          onPressed: () {
            nextScreen(context, HomePage());
          },
        ),
      ),
    );
  }
}
