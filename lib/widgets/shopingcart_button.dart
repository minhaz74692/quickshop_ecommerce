// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quickshop_ecommerce/models/products_model.dart';
import 'package:quickshop_ecommerce/screens/cart.dart';
import 'package:quickshop_ecommerce/utils/nextscreen.dart';

class ShopingCartButton extends StatelessWidget {
  const ShopingCartButton({super.key, required this.productListInCart});
  final List<ProductsModel> productListInCart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Stack(
        children: [
          IconButton(
            onPressed: () {
              nextScreen(context, Cart());
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.grey,
            ),
          ),
          Positioned(
            right: 0,
            child: Text(
              productListInCart.isEmpty
                  ? ''
                  : productListInCart.length.toString(),
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
