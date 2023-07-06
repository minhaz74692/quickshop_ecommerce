import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:quickshop_ecommerce/constants/constants.dart';
import 'package:quickshop_ecommerce/models/categories_model.dart';
import 'package:quickshop_ecommerce/models/products_model.dart';
import 'package:quickshop_ecommerce/utils/products_list.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<CategoryModel>> getCategoryList() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection('Categories').get();

      List<CategoryModel> categoryList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();
      print(categoryList[1].image);
      return categoryList;
    } catch (e) {
      showMessage(e.toString());
      print(e.toString());
      return [];
    }
  }

  Future<List<ProductsModel>> getProductList() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collectionGroup('products').get();

      List<ProductsModel> productList = querySnapshot.docs
          .map((e) => ProductsModel.fromJson(e.data()))
          .toList();
      print(productList[1].image);
      return productList;
    } catch (e) {
      showMessage(e.toString());
      print(e.toString());
      return [];
    }
  }

  Future<List<ProductsModel>> getCategoryView(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection('Categories')
              .doc(id)
              .collection('products')
              .get();

      List<ProductsModel> productList = querySnapshot.docs
          .map((e) => ProductsModel.fromJson(e.data()))
          .toList();
      print(productList[1].image);
      return productList;
    } catch (e) {
      showMessage(e.toString());
      print(e.toString());
      return [];
    }
  }
}
