// ignore_for_file: prefer_const_constructors, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Constants {
  static final bookmarkTag = 'bookmarkTag';
}

void showMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0);
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(
      builder: (context) {
        return SizedBox(
          width: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: Colors.blue,
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                margin: EdgeInsets.only(left: 7),
                child: Text('Loading...'),
              ),
            ],
          ),
        );
      },
    ),
  );
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}

bool loginValidation(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    showMessage('Both email and password is empty');
    return false;
  } else if (email.isEmpty) {
    showMessage('Email is empty');
    return false;
  } else if (password.isEmpty) {
    showMessage('Password is empty');
    return false;
  } else {
    return true;
  }
}

bool signUpValidation(
    String email, String password, String name, String phone) {
  if (email.isEmpty && password.isEmpty && name.isEmpty && phone.isEmpty) {
    showMessage('All Fields are empty');
    return false;
  } else if (email.isEmpty) {
    showMessage('Email is empty');
    return false;
  } else if (password.isEmpty) {
    showMessage('Password is empty');
    return false;
  } else if (name.isEmpty) {
    showMessage('Name is empty');
    return false;
  } else if (phone.isEmpty) {
    showMessage('Phone number is empty');
    return false;
  } else {
    return true;
  }
}
