// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:quickshop_ecommerce/tabs/home_tab.dart';
import 'package:quickshop_ecommerce/utils/nextscreen.dart';

class OrderConfirmedPage extends StatelessWidget {
  const OrderConfirmedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
                'Your order placed Successfully. Thank You for shopping with us.'),
            ElevatedButton(
              onPressed: () {
                nextScreenCloseOthers(context, HomeTab());
              },
              child: Text('Continue Shopping'),
            ),
          ],
        ),
      ),
    );
  }
}
