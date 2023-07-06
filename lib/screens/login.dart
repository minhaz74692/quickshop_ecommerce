// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:quickshop_ecommerce/constants/constants.dart';
import 'package:quickshop_ecommerce/firebase_helper/auth.dart';
import 'package:quickshop_ecommerce/screens/signup.dart';
import 'package:quickshop_ecommerce/tabs/home_tab.dart';
import 'package:quickshop_ecommerce/utils/nextscreen.dart';
import 'package:quickshop_ecommerce/widgets/primary_button.dart';
import 'package:quickshop_ecommerce/widgets/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool showPassword = true;
  late IconData lockIcon = Icons.visibility;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void _submitForm() async {
    // Perform form submission logic here
    bool valid = loginValidation(email.text, password.text);
    if (valid) {
      bool isLogin = await FirebaseAuthHelper.instance
          .login(email.text, password.text, context);
      if (isLogin) {
        nextScreenCloseOthers(context, HomeTab());
      } else {
        showMessage('Invalid Email or Password');
        Navigator.pop(context);
      }
    }
    print('Form submitted!');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 25,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TopTitles(
                title: 'Log In',
                subTitle: 'Welcome again to the QuickShop App',
              ),
              SizedBox(
                height: 45,
              ),
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                onEditingComplete: _submitForm,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined,
                    ),
                    hintText: 'E-mail'),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: password,
                obscureText: showPassword,
                onEditingComplete: _submitForm,
                decoration: InputDecoration(
                    suffixIcon: CupertinoButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                          lockIcon = lockIcon == Icons.visibility
                              ? Icons.visibility_off
                              : Icons.visibility;
                        });
                      },
                      child: Icon(
                        lockIcon,
                        color: Colors.grey,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.lock_open_outlined,
                    ),
                    hintText: 'Password'),
              ),
              SizedBox(height: 35),
              PrimaryButton(title: 'Log In', onPressed: _submitForm),
              SizedBox(height: 18),
              Center(child: Text('Do not have an account?')),
              SizedBox(height: 0),
              Center(
                child: CupertinoButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    nextScreen(context, SignUp());
                  },
                  child: Text(
                    'create account',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
