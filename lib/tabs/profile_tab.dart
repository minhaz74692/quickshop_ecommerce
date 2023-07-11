// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickshop_ecommerce/firebase_helper/auth.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    final ub = context.watch<FirebaseAuthHelper>();
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          print(ub.isSignedIn);
        },
        child: Text('Print'),
      )),
    );
  }
}
