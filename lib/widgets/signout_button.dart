// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quickshop_ecommerce/providers/auth.dart';
import 'package:quickshop_ecommerce/screens/Welcome_page.dart';
import 'package:quickshop_ecommerce/utils/nextscreen.dart';

class SignoutButton extends StatelessWidget {
  const SignoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sign Out'),
              content: Text('Are you sure to Sign Out?'),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Perform an action when the user taps on the button
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        // Perform an action when the user taps on the button
                        await FirebaseAuthBloc().signOut();
                        // ignore: use_build_context_synchronously
                        nextScreenCloseOthers(context, WelcomePage());
                      },
                      child: Text('Sign Out'),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ],
            );
          },
        );
      },
      icon: Icon(
        Icons.logout,
        color: Colors.grey,
        size: 24,
      ),
    );
  }
}
