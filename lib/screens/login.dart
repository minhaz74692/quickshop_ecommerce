// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:provider/provider.dart';
import 'package:quickshop_ecommerce/constants/constants.dart';
import 'package:quickshop_ecommerce/providers/auth.dart';
import 'package:quickshop_ecommerce/screens/home_page.dart';
import 'package:quickshop_ecommerce/screens/signup.dart';
import 'package:quickshop_ecommerce/utils/nextscreen.dart';
import 'package:quickshop_ecommerce/widgets/primary_button.dart';
import 'package:quickshop_ecommerce/widgets/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool showPassword = true;
  late IconData lockIcon = Icons.visibility;
  TextEditingController email = TextEditingController(text: 'admin@gmail.com');
  TextEditingController password = TextEditingController(text: 'admin1');

  handleSignInwithemailPassword() async {
    final FirebaseAuthBloc sb =
        Provider.of<FirebaseAuthBloc>(context, listen: false);
    showLoaderDialog(context);
    await sb.signInwithEmailPassword(email.text, password.text).then((_) async {
      if (sb.hasError == false) {
        sb.setSignIn().then((value) {
          nextScreen(context, HomePage());
        });
      } else {
        showMessage(sb.errorCode.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            TopTitles(
              title: 'Log In',
              subTitle: 'Welcome again to the QuickShop',
            ),
            SizedBox(
              height: 45,
            ),
            TextFormField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              onEditingComplete: handleSignInwithemailPassword,
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
              onEditingComplete: handleSignInwithemailPassword,
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
            PrimaryButton(
                title: 'Log In', onPressed: handleSignInwithemailPassword),
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
    );
  }
}
