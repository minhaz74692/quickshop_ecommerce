import 'package:quickshop_ecommerce/models/products_model.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.id, required this.product});
  final String id;
  final ProductsModel? product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: Center(
        child: Text(product!.name),
      ),
    );
  }
}
