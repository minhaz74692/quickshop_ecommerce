// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:e_commerce_app/models/products_model.dart';
import 'package:e_commerce_app/screens/product_details.dart';
import 'package:e_commerce_app/utils/nextscreen.dart';
import 'package:e_commerce_app/utils/products_list.dart';
import 'package:e_commerce_app/widgets/top_titles.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 250, 250, 255),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Text(
                  'QuickShop',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //       children: categoriesList
              //           .map(
              //             (e) => Padding(
              //               padding: EdgeInsets.all(5),
              //               child: Card(
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(20.0),
              //                 ),
              //                 elevation: 6.0,
              //                 child: SizedBox(
              //                   height: 80,
              //                   width: 80,
              //                   child: Image.network(e),
              //                 ),
              //               ),
              //             ),
              //           )
              //           .toList()),
              // ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: imageMapList.entries.map((e) {
                  String imageName = e.key;
                  String imageUrl = e.value;
                  return Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 6.0,
                        child: Container(
                          color: Colors.white,
                          height: 80,
                          width: 80,
                          child: Image.network(imageUrl),
                        ),
                      ),
                      Text(imageName),
                    ],
                  );
                }).toList()),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Best Products',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: ProductList().products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (BuildContext context, int index) {
                  ProductsModel singleProduct = ProductList().products[index];
                  // return Text(singleProduct.name);
                  return Container(
                    padding: EdgeInsets.all(10),
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
                              width: 80,
                              height: 80,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              singleProduct.description.length > 20
                                  ? '${singleProduct.description.substring(0, 30)}...'
                                  : singleProduct.description,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Price: \u{09F3}${singleProduct.price} ',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: SizedBox(
                              height: 40,
                              width: 100,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                onPressed: () {
                                  nextScreen(
                                      context,
                                      ProductDetails(
                                          id: singleProduct.id,
                                          product: singleProduct));
                                },
                                child: Text(
                                  'Buy',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
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
            ],
          ),
        ),
      ),
    );
  }
}

List<String> categoriesList = [
  'https://img.freepik.com/premium-vector/electronics-devices-set-icons_24877-6066.jpg',
  'https://i.pinimg.com/originals/07/36/df/0736df35c198525e6493d648bf8fc38e.png',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGjDGL3tHu2bSdWp2Cgcvn9A-uIxDP4QW4fg&usqp=CAU',
  'https://img.freepik.com/free-vector/hand-drawn-flat-design-stack-books-illustration_23-2149341898.jpg',
];

Map<String, dynamic> imageMapList = {
  'Electronics':
      'https://img.freepik.com/premium-vector/electronics-devices-set-icons_24877-6066.jpg',
  'Groceries':
      'https://i.pinimg.com/originals/07/36/df/0736df35c198525e6493d648bf8fc38e.png',
  'Cloths':
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGjDGL3tHu2bSdWp2Cgcvn9A-uIxDP4QW4fg&usqp=CAU',
  'Books':
      'https://img.freepik.com/free-vector/hand-drawn-flat-design-stack-books-illustration_23-2149341898.jpg',
};


// Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: GridView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       scrollDirection: Axis.vertical,
//                       itemCount: ProductList().products.length,
//                       // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       //   crossAxisCount: 2,
//                       //   crossAxisSpacing: 15,
//                       //   mainAxisSpacing: 10,
//                       //   childAspectRatio: 0.7,
//                       // ),
//                       itemBuilder: (BuildContext context, int index) {
//                         ProductsModel singleProduct =
//                             ProductList().products[index];
//                         // return Text(singleProduct.name);
//                         return Column(
//                           children: [
//                             if (index.isEven)
//                               Container(
//                                 padding: EdgeInsets.all(10),
//                                 width: MediaQuery.of(context).size.width / 2,
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: Colors.white,
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Center(
//                                         child: Image.network(
//                                           singleProduct.image,
//                                           width: 80,
//                                           height: 80,
//                                         ),
//                                       ),
//                                       Container(
//                                         margin: EdgeInsets.only(top: 5),
//                                         padding:
//                                             EdgeInsets.symmetric(horizontal: 8),
//                                         child: Text(
//                                           singleProduct.description.length > 20
//                                               ? '${singleProduct.description.substring(0, 30)}...'
//                                               : singleProduct.description,
//                                           style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 8.0),
//                                         child: Text(
//                                           'Price: \u{09F3}${singleProduct.price} ',
//                                           style: TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.w500,
//                                               color: Colors.red),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                       Center(
//                                         child: SizedBox(
//                                           height: 40,
//                                           width: 100,
//                                           child: OutlinedButton(
//                                             style: OutlinedButton.styleFrom(
//                                               side: BorderSide(
//                                                 color: Colors.blue,
//                                               ),
//                                             ),
//                                             onPressed: () {
//                                               nextScreen(
//                                                   context,
//                                                   ProductDetails(
//                                                       id: singleProduct.id,
//                                                       product: singleProduct));
//                                             },
//                                             child: Text(
//                                               'Buy',
//                                               style: TextStyle(
//                                                   fontSize: 18,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.blue),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: ListView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       scrollDirection: Axis.vertical,
//                       itemCount: ProductList().products.length,
//                       // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       //   crossAxisCount: 2,
//                       //   crossAxisSpacing: 15,
//                       //   mainAxisSpacing: 10,
//                       //   childAspectRatio: 0.7,
//                       // ),
//                       itemBuilder: (BuildContext context, int index) {
//                         ProductsModel singleProduct =
//                             ProductList().products[index];
//                         // return Text(singleProduct.name);
//                         return Column(
//                           children: [
//                             if (index.isOdd)
                              // Container(
                              //   padding: EdgeInsets.all(10),
                              //   width: MediaQuery.of(context).size.width / 2,
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(10),
                              //       color: Colors.white,
                              //     ),
                              //     child: Column(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //       children: [
                              //         Center(
                              //           child: Image.network(
                              //             singleProduct.image,
                              //             width: 80,
                              //             height: 80,
                              //           ),
                              //         ),
                              //         Container(
                              //           margin: EdgeInsets.only(top: 5),
                              //           padding:
                              //               EdgeInsets.symmetric(horizontal: 8),
                              //           child: Text(
                              //             singleProduct.description.length > 20
                              //                 ? '${singleProduct.description.substring(0, 30)}...'
                              //                 : singleProduct.description,
                              //             style: TextStyle(
                              //               fontSize: 16,
                              //               fontWeight: FontWeight.w600,
                              //             ),
                              //           ),
                              //         ),
                              //         SizedBox(
                              //           height: 10,
                              //         ),
                              //         Padding(
                              //           padding: EdgeInsets.symmetric(
                              //               horizontal: 8.0),
                              //           child: Text(
                              //             'Price: \u{09F3}${singleProduct.price} ',
                              //             style: TextStyle(
                              //                 fontSize: 18,
                              //                 fontWeight: FontWeight.w500,
                              //                 color: Colors.red),
                              //           ),
                              //         ),
                              //         SizedBox(
                              //           height: 10,
                              //         ),
                              //         Center(
                              //           child: SizedBox(
                              //             height: 40,
                              //             width: 100,
                              //             child: OutlinedButton(
                              //               style: OutlinedButton.styleFrom(
                              //                 side: BorderSide(
                              //                   color: Colors.blue,
                              //                 ),
                              //               ),
                              //               onPressed: () {
                              //                 nextScreen(
                              //                     context,
                              //                     ProductDetails(
                              //                         id: singleProduct.id,
                              //                         product: singleProduct));
                              //               },
                              //               child: Text(
                              //                 'Buy',
                              //                 style: TextStyle(
                              //                     fontSize: 18,
                              //                     fontWeight: FontWeight.bold,
                              //                     color: Colors.blue),
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
              //             ],
              //           );
              //         },
              //       ),
              //     ),
              //   ],
              // )