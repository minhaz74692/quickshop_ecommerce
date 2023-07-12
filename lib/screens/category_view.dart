// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:quickshop_ecommerce/firebase_helper/firebase_data.dart';
import 'package:quickshop_ecommerce/models/categories_model.dart';
import 'package:quickshop_ecommerce/models/products_model.dart';
import 'package:quickshop_ecommerce/screens/product_details.dart';
import 'package:quickshop_ecommerce/utils/nextscreen.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key, required this.categoryModel});
  final CategoryModel categoryModel;

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ProductsModel> productList = [];
  bool isLoading = false;

  @override
  void initState() {
    getProductList();
    super.initState();
  }

  void getProductList() async {
    setState(() {
      isLoading = true;
    });
    productList = await FirebaseFirestoreHelper.instance
        .getCategoryView(widget.categoryModel.id);
    // productList = await FirebaseFirestoreHelper.instance.getProductList();
    productList.shuffle();
    setState(() {
      isLoading = false;
    });
    print(widget.categoryModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.categoryModel.name,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: isLoading
            ? Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 20),
                child: GridView.builder(
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
                    // return Text(singleProduct.name);
                    return InkWell(
                      onTap: () => nextScreen(
                          context,
                          ProductDetails(
                              id: singleProduct.id, product: singleProduct)),
                      child: Container(
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
                              Center(
                                child: Image.network(
                                  singleProduct.image,
                                  width: 120,
                                  height: 120,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                padding: EdgeInsets.symmetric(horizontal: 8),
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
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
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
                              Center(
                                child: SizedBox(
                                  height: 35,
                                  width: 150,
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 7, 255, 27),

                                      // side: BorderSide(
                                      //   color: Colors.blue,
                                      // ),
                                    ),
                                    onPressed: () {
                                      nextScreen(
                                          context,
                                          ProductDetails(
                                              id: singleProduct.id,
                                              product: singleProduct));
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
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
