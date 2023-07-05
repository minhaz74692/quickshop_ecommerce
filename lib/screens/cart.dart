import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:quickshop_ecommerce/blocs/product_bloc.dart';
import 'package:quickshop_ecommerce/models/products_model.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

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
