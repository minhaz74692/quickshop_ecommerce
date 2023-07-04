// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:quickshop_ecommerce/models/products_model.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.id, required this.product});
  final String id;
  final ProductsModel? product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int prouctCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  widget.product!.image,
                  height: 350,
                  width: 350,
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.product!.name,
                      // overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.product!.isfavourite =
                            !widget.product!.isfavourite;
                      });
                    },
                    icon: Icon(
                      widget.product!.isfavourite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      size: 24.0,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(widget.product!.description),
              ),
              Row(
                children: [
                  CircleAvatar(
                    child: IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (prouctCount > 0) {
                          setState(() {
                            prouctCount--;
                          });
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      prouctCount.toString(),
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  CircleAvatar(
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          prouctCount++;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 38,
                    width: 140,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text('ADD TO CART'),
                    ),
                  ),
                  SizedBox(width: 12.0),
                  SizedBox(
                    height: 38,
                    width: 140,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('BUY'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
