import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:quickshop_ecommerce/blocs/product_bloc.dart';
import 'package:quickshop_ecommerce/models/products_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
    // int count = Provider.of<ProductBloc>(context).count;
    // int totalPrice = Provider.of<ProductBloc>(context).price;
    double price = 0;
    List<ProductsModel> productListInCart =
        Provider.of<ProductBloc>(context).productListOfCart;
    // for (var i = 0; i <= productListInCart.length; i++) {
    //   totalPrice = totalPrice + productListInCart[i].price;
    // }
    double totalPrice() {
      for (var i = 0; i < productListInCart.length; i++) {
        price = price + productListInCart[i].price;
      }
      return price;
    }

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(productListInCart.length.toString()),
          // Text(totalPrice.toString()),
          Text(totalPrice().toString()),
          ElevatedButton(
              onPressed: () {
                print(productListInCart[0].id);
              },
              child: Text('Print the product list'))
        ],
      ),
    );
  }
}
