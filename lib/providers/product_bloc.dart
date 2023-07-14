import 'package:flutter/material.dart';
import 'package:quickshop_ecommerce/models/products_model.dart';

class ProductBloc extends ChangeNotifier {
  int count = 0;
  int price = 0;
  List<ProductsModel> productListOfCart = [];

  List<ProductsModel> bookmarkedProductList = [];

  void addProductToCart(ProductsModel x) {
    productListOfCart.add(x);
    notifyListeners();
  }

  void addProductToBookmark(ProductsModel x) {
    bookmarkedProductList.add(x);
    notifyListeners();
  }

  void removeProductFromBookmark(ProductsModel x) {
    bookmarkedProductList.remove(x);
    notifyListeners();
  }

  void clearProductFromBookmark() {
    bookmarkedProductList.clear();
    notifyListeners();
  }

  void removeProductFromCart(ProductsModel x) {
    productListOfCart.remove(x);
    notifyListeners();
  }

  void increment() {
    count++;
    notifyListeners();
  }

  void decrement() {
    if (count > 0) {
      count--;
      notifyListeners();
    }
  }

  void removePrice(int x) {
    if (price > x) {
      price = price - x;
      notifyListeners();
    }
  }

  void addPrice(int x) {
    price = price + x;
    notifyListeners();
  }
}
