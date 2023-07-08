// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:provider/provider.dart';
import 'package:quickshop_ecommerce/blocs/product_bloc.dart';
import 'package:quickshop_ecommerce/constants/constants.dart';
import 'package:quickshop_ecommerce/firebase_helper/auth.dart';
import 'package:quickshop_ecommerce/firebase_helper/firebase_data.dart';
import 'package:quickshop_ecommerce/models/categories_model.dart';
import 'package:quickshop_ecommerce/models/products_model.dart';
import 'package:quickshop_ecommerce/screens/Welcome_page.dart';
import 'package:quickshop_ecommerce/screens/cart.dart';
import 'package:quickshop_ecommerce/screens/category_view.dart';
import 'package:quickshop_ecommerce/screens/product_details.dart';
import 'package:quickshop_ecommerce/utils/app_name.dart';
import 'package:quickshop_ecommerce/utils/nextscreen.dart';
import 'package:quickshop_ecommerce/widgets/drawer.dart';
import 'package:flutter/material.dart';

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
    List<ProductsModel> productListInCart =
        Provider.of<ProductBloc>(context).productListOfCart;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppName(
                  fontSize: 24,
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
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
                          productListInCart.isEmpty
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
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Sign Out'),
                      content: Text('Are you sure to Sign Out?'),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                // Perform an action when the user taps on the button
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                // Perform an action when the user taps on the button
                                await FirebaseAuthHelper.instance.signOut();
                                // ignore: use_build_context_synchronously
                                nextScreenCloseOthers(context, WelcomePage());
                              },
                              child: Text('Sign Out'),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(
                Icons.logout,
                size: 24,
              ),
            ),
          ],
        ),
        drawer: DrawerMenu(),
        key: scaffoldKey,
        backgroundColor: Color.fromARGB(255, 250, 250, 255),
        body: isLoading
            ? Center(
                child: Container(
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
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 40,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search_outlined),
                        ),
                      ),
                    ),
                    // SizedBox(height: 8.0),
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
                            return InkWell(
                              onTap: () {
                                nextScreen(
                                    context,
                                    CategoryView(
                                      categoryModel: e,
                                    ));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey
                                              .withOpacity(0.5), // shadow color
                                          spreadRadius: 2, // spread radius
                                          blurRadius: 5, // blur radius
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(40.0),
                                      color: Colors.white,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image.network(
                                        imageUrl,
                                        // fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Text(imageName),
                                ],
                              ),
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
                        return Container(
                          padding: EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width / 2,
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
                                    ProductDetails(
                                        id: singleProduct.id,
                                        product: singleProduct),
                                  ),
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Image.network(
                                          singleProduct.image,
                                          width: 120,
                                          height: 120,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5),
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: Text(
                                          singleProduct.description.length > 28
                                              ? '${singleProduct.description.substring(0, 28)}...'
                                              : '${singleProduct.description}...',
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          'Price: \u{09F3}${singleProduct.price.toString()} ',
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
                                        backgroundColor:
                                            Color.fromARGB(255, 7, 255, 27),
                                      ),
                                      onPressed: () {
                                        if (thisProductList.length < 5) {
                                          Provider.of<ProductBloc>(context,
                                                  listen: false)
                                              .addProductToCart(singleProduct);
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
                              ],
                            ),
                          ),
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
