// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:quickshop_ecommerce/constants/constants.dart';
import 'package:quickshop_ecommerce/providers/auth.dart';
import 'package:quickshop_ecommerce/screens/home_page.dart';
import 'package:quickshop_ecommerce/screens/login.dart';
import 'package:quickshop_ecommerce/utils/nextscreen.dart';
import 'package:quickshop_ecommerce/widgets/primary_button.dart';
import 'package:quickshop_ecommerce/widgets/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool showPassword = true;
  late IconData lockIcon = Icons.visibility;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  handleSignUpwithemailPassword() async {
    final FirebaseAuthBloc sb =
        Provider.of<FirebaseAuthBloc>(context, listen: false);
    showLoaderDialog(context);
    await sb
        .signUpwithEmailPassword(name.text, email.text, password.text)
        .then((_) async {
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
              title: 'Create an account',
              subTitle: 'Have a good experience with QuickShop',
            ),
            SizedBox(
              height: 45,
            ),
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person_outline,
                  ),
                  hintText: 'Full Name'),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email_outlined,
                  ),
                  hintText: 'E-mail'),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: phone,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone_outlined,
                  ),
                  hintText: 'Phone Number'),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: password,
              obscureText: showPassword,
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
                title: 'Sign Up',
                onPressed: () async {
                  bool isValid = signUpValidation(
                      email.text, password.text, name.text, phone.text);
                  if (isValid) {
                    handleSignUpwithemailPassword();
                  }
                }),
            SizedBox(height: 18),
            Center(child: Text('I have already an account?')),
            SizedBox(height: 0),
            Center(
              child: CupertinoButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  nextScreen(context, LogIn());
                },
                child: Text(
                  'Log In',
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
