// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:provider/provider.dart';
import 'package:quickshop_ecommerce/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthHelper {
  static FirebaseAuthHelper instance = FirebaseAuthHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> get getAuthChange => _auth.authStateChanges();

  // final GoogleSignIn _googlSignIn = new GoogleSignIn();

  bool _guestUser = false;
  bool get guestUser => _guestUser;

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _hasError = false;
  bool get hasError => _hasError;

  String? _errorCode;
  String? get errorCode => _errorCode;

  String? _name;
  String? get name => _name;

  String? _uid;
  String? get uid => _uid;

  String? _email;
  String? get email => _email;

  String? _imageUrl;
  String? get imageUrl => _imageUrl;

  String? _signInProvider;
  String? get signInProvider => _signInProvider;

  String? timestamp;

  String _appVersion = '0.0';
  String get appVersion => _appVersion;

  String _packageName = '';
  String get packageName => _packageName;

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

  // Future signInWithGoogle() async {
  //   final GoogleSignInAccount? googleUser = await _googlSignIn.signIn();
  //   if (googleUser != null) {
  //     try {
  //       final GoogleSignInAuthentication googleAuth =
  //           await googleUser.authentication;

  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken,
  //       );

  //       User userDetails = (await _auth.signInWithCredential(credential)).user!;

  //       this._name = userDetails.displayName;
  //       this._email = userDetails.email;
  //       this._imageUrl = userDetails.photoURL;
  //       this._uid = userDetails.uid;
  //       this._signInProvider = 'google';

  //       _hasError = false;
  //       // notifyListeners();
  //     } catch (e) {
  //       _hasError = true;
  //       _errorCode = e.toString();
  //       // notifyListeners();
  //     }
  //   } else {
  //     _hasError = true;
  //     // notifyListeners();
  //   }
  // }

  Future signOut() async {
    await _auth.signOut();
  }
}
