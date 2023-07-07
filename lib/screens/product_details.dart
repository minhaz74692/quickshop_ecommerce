// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:provider/provider.dart';
import 'package:quickshop_ecommerce/blocs/product_bloc.dart';
import 'package:quickshop_ecommerce/constants/constants.dart';
import 'package:quickshop_ecommerce/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:quickshop_ecommerce/screens/cart.dart';
import 'package:quickshop_ecommerce/utils/nextscreen.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.id, required this.product});
  final String id;
  final ProductsModel? product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    int count = Provider.of<ProductBloc>(context).count;

    List<ProductsModel> productListInCart =
        Provider.of<ProductBloc>(context).productListOfCart;
    List<ProductsModel> thisProductList = productListInCart
        .where((product) => product.id == widget.product!.id)
        .toList();

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
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
                    productListInCart.length == 0
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
          ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 12.0, top: 12.0),
          //   child:
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
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
                child: Text(
                  widget.product!.description,
                  style: TextStyle(),
                ),
              ),
              Text(
                'Unit Price: \u{09F3}${widget.product!.price}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 12),

              Row(
                children: [
                  CircleAvatar(
                    child: IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (thisProductList.isNotEmpty) {
                          // setState(() {
                          //   prouctCount--;
                          // });
                          // Provider.of<ProductBloc>(context, listen: false)
                          //     .decrement();
                          // Provider.of<ProductBloc>(context, listen: false)
                          //     .addPrice(widget.product!.price.toInt());
                          Provider.of<ProductBloc>(context, listen: false)
                              .removeProductFromCart(widget.product!);
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      thisProductList.length.toString(),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        // setState(() {
                        //   prouctCount++;
                        // });
                        // Provider.of<ProductBloc>(context, listen: false)
                        //     .increment();
                        // Provider.of<ProductBloc>(context, listen: false)
                        //     .addPrice(widget.product!.price.toInt());
                        if (thisProductList.length < 5) {
                          Provider.of<ProductBloc>(context, listen: false)
                              .addProductToCart(widget.product!);
                        } else {
                          showMessage(
                              'You can not buy a product more then 5 unit at a time.');
                        }
                      },
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      thisProductList.isEmpty
                          ? 'Price: \u{09F3}0'
                          : 'Price: \u{09F3}${thisProductList.length * thisProductList[0].price}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              // Spacer(), If I add this spacer inside a ScrollView then error will occur...
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 38,
                    width: 140,
                    child: OutlinedButton(
                      onPressed: () {
                        nextScreen(context, Cart());
                      },
                      child: Text('ADD TO CART'),
                    ),
                  ),
                  SizedBox(width: 12.0),
                  SizedBox(
                    height: 38,
                    width: 140,
                    child: ElevatedButton(
                      onPressed: () {
                        nextScreen(context, Cart());
                      },
                      child: Text('BUY'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
