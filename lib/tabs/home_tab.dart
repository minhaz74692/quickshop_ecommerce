// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:provider/provider.dart';
import 'package:quickshop_ecommerce/cards/card1.dart';
import 'package:quickshop_ecommerce/providers/product_bloc.dart';
import 'package:quickshop_ecommerce/providers/auth.dart';
import 'package:quickshop_ecommerce/firebase_helper/firebase_data.dart';
import 'package:quickshop_ecommerce/models/categories_model.dart';
import 'package:quickshop_ecommerce/models/products_model.dart';
import 'package:quickshop_ecommerce/utils/app_name.dart';
import 'package:quickshop_ecommerce/widgets/category_card.dart';
import 'package:quickshop_ecommerce/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:quickshop_ecommerce/widgets/shopingcart_button.dart';
import 'package:quickshop_ecommerce/widgets/signout_button.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<CategoryModel> categoriesList = [];
  List<ProductsModel> productList = [];
  bool isLoading = false;

  @override
  void initState() {
    getCateriesList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getCateriesList() async {
    setState(() {
      isLoading = true;
    });
    categoriesList = await FirebaseFirestoreHelper.instance.getCategoryList();
    productList = await FirebaseFirestoreHelper.instance.getProductList();
    productList.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final ub = context.watch<FirebaseAuthBloc>();
    print(ub.isSignedIn);
    List<ProductsModel> productListInCart =
        Provider.of<ProductBloc>(context).productListOfCart;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: AppName(
            fontSize: 24,
          ),
          actions: [
            Row(
              children: [
                ShopingCartButton(
                  productListInCart: productListInCart,
                ),
                SignoutButton(),
                SizedBox(width: 5),
              ],
            ),
          ],
        ),
        drawer: DrawerMenu(),
        key: scaffoldKey,
        backgroundColor: Color.fromARGB(255, 250, 250, 255),
        body: isLoading
            ? Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Categories',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: categoriesList.map((e) {
                            String imageName = e.name;
                            String imageUrl = e.image;
                            return CategoryCard(
                              categoryModel: e,
                              imageName: imageName,
                              imageUrl: imageUrl,
                            );
                          }).toList()),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Best Products',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      // itemCount: ProductList().products.length,
                      itemCount: productList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.6,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        ProductsModel singleProduct =
                            // ProductList().products[index];
                            productList[index];
                        List<ProductsModel> thisProductList = productListInCart
                            .where((product) => product.id == singleProduct.id)
                            .toList();
                        // return Text(singleProduct.name);
                        return Card1(
                          product: singleProduct,
                          thisProductList: thisProductList,
                        );
                      },
                    ),
                    SizedBox(height: 12.0),
                  ],
                ),
              ),
      ),
    );
  }
}
