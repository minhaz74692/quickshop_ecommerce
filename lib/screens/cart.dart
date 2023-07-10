// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:quickshop_ecommerce/blocs/product_bloc.dart';
import 'package:quickshop_ecommerce/constants/constants.dart';
import 'package:quickshop_ecommerce/models/products_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:quickshop_ecommerce/screens/checkout.dart';
import 'package:quickshop_ecommerce/screens/home_page.dart';
import 'package:quickshop_ecommerce/screens/product_details.dart';
import 'package:quickshop_ecommerce/tabs/home_tab.dart';
import 'package:quickshop_ecommerce/utils/nextscreen.dart';

class Cart extends StatefulWidget {
  Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final FirebaseStorage storage = FirebaseStorage.instance;

  String imageUrl = 'evefvuhu';

  @override
  void initState() {
    // TODO: implement initState
    fetchAllImageUrls();
    super.initState();
    print(imageUrl);
  }

  Future<List<String>> fetchAllImageUrls() async {
    try {
      final ListResult result = await storage.ref().listAll();
      final List<String> imageUrls = [];

      for (final Reference ref in result.items) {
        final String downloadUrl = await ref.getDownloadURL();
        final FullMetadata metadata = await ref.getMetadata();
        final String? mimeType = metadata.contentType;

        if (mimeType != null && mimeType.startsWith('image/')) {
          imageUrls.add(downloadUrl);
        }
      }

      print(imageUrls);
      return imageUrls;
    } catch (e) {
      print('Failed to fetch data');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ProductsModel> productListInCart =
        Provider.of<ProductBloc>(context).productListOfCart;
    List<ProductsModel> sortedProductList = productListInCart.toSet().toList();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 250, 255),
      appBar: AppBar(
        leading: BackButton(),
        title: Text(
          'Your Cart',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: productListInCart.isEmpty
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/emptyCart.png',
                    width: 200,
                  ),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => nextScreenCloseOthers(context, HomeTab()),
                    child: Text(
                      'Add Item',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: sortedProductList.length,
                    itemBuilder: (ctx, index) {
                      ProductsModel singleProduct = sortedProductList[index];
                      List<ProductsModel> thisProductList = productListInCart
                          .where((product) => product.id == singleProduct.id)
                          .toList();

                      return Container(
                        margin: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 1),
                              blurRadius: 3,
                              spreadRadius: 1,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          // border: Border.all(color: Colors.blue, width: 2),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                height: 140,
                                child: Image.network(singleProduct.image),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 140,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 200,
                                      child: Text(
                                        singleProduct.name.length > 28
                                            ? '${singleProduct.name.substring(0, 28)}...'
                                            : '${singleProduct.name}...',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          child: IconButton(
                                            icon: Icon(Icons.remove),
                                            onPressed: () {
                                              if (thisProductList.isNotEmpty) {
                                                Provider.of<ProductBloc>(
                                                        context,
                                                        listen: false)
                                                    .removeProductFromCart(
                                                        singleProduct);
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
                                              if (thisProductList.length < 5) {
                                                Provider.of<ProductBloc>(
                                                        context,
                                                        listen: false)
                                                    .addProductToCart(
                                                        singleProduct);
                                              } else {
                                                showMessage(
                                                    'You can not buy a product more then 5 unit at a time.');
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Price: \u{09F3}${thisProductList.length * singleProduct.price}',
                                          style: TextStyle(
                                            fontSize: 22,
                                            color: Colors.red,
                                          ),
                                        ),
                                        Spacer(),
                                        TextButton(
                                          onPressed: () {
                                            nextScreen(
                                                context,
                                                ProductDetails(
                                                    id: singleProduct.id,
                                                    product: singleProduct));
                                          },
                                          child: Text('details'),
                                        ),
                                        SizedBox(width: 5),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        nextScreen(context, CheckOutPage());
                      },
                      child: Text(
                        'Review Payment and Address',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
    );
  }
}
