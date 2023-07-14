// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickshop_ecommerce/constants/constants.dart';
import 'package:quickshop_ecommerce/models/products_model.dart';
import 'package:quickshop_ecommerce/providers/product_bloc.dart';
import 'package:quickshop_ecommerce/screens/product_details.dart';
import 'package:quickshop_ecommerce/utils/nextscreen.dart';

class Card1 extends StatelessWidget {
  const Card1(
      {super.key, required this.product, required this.thisProductList});
  final ProductsModel product;
  final List<ProductsModel> thisProductList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => nextScreen(
                context,
                ProductDetails(id: product.id, product: product),
              ),
              child: Column(
                children: [
                  Center(
                    child: Image.network(
                      product.image,
                      width: 120,
                      height: 120,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      product.description.length > 28
                          ? '${product.description.substring(0, 28)}...'
                          : '${product.description}...',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Price: \u{09F3}${product.price.toString()} ',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.red),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Center(
              child: SizedBox(
                height: 35,
                width: 150,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 7, 255, 27),
                  ),
                  onPressed: () {
                    if (thisProductList.length < 5) {
                      Provider.of<ProductBloc>(context, listen: false)
                          .addProductToCart(product);
                    } else {
                      showMessage(
                          'You can not buy a product more then 5 unit at a time.');
                    }
                  },
                  child: Text(
                    'Add To Cart',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
