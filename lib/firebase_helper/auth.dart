// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:e_commerce_app/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthHelper {
  static FirebaseAuthHelper instatnce = FirebaseAuthHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> get getAuthChange => _auth.authStateChanges();

  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print('$email: is a subscriber');
      return true;
    } on FirebaseException catch (e) {
      print(e.code.toString());
      return false;
    }
  }

  // Sign-Up Logic with firebase
  Future<bool> signUp(
      String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('$email: is a subscriber');
      return true;
    } on FirebaseException catch (e) {
      print(e.code.toString());
      return false;
    }
  }
}
