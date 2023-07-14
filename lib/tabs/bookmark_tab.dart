// // ignore_for_file: prefer_const_constructors

// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unused_element

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickshop_ecommerce/cards/card1.dart';
import 'package:quickshop_ecommerce/config/config.dart';
import 'package:quickshop_ecommerce/models/products_model.dart';
import 'package:quickshop_ecommerce/providers/product_bloc.dart';
import 'package:quickshop_ecommerce/utils/empty_image.dart';

class BookMarkTab extends StatefulWidget {
  const BookMarkTab({super.key});

  @override
  State<BookMarkTab> createState() => _BookMarkTabState();
}

class _BookMarkTabState extends State<BookMarkTab> {
  void _openCLearAllDialog(void Function() _onPressed) {
    showModalBottomSheet(
        elevation: 2,
        enableDrag: true,
        isDismissible: true,
        isScrollControlled: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (context) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            height: 210,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'clear all bookmark-dialog',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.6,
                      wordSpacing: 1),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      child: Text(
                        'Yes',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.resolveWith(
                              (states) => Size(100, 50)),
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Theme.of(context).primaryColor),
                          shape: MaterialStateProperty.resolveWith(
                              (states) => RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ))),
                      onPressed: _onPressed,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.resolveWith(
                              (states) => Size(100, 50)),
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.grey[400]),
                          shape: MaterialStateProperty.resolveWith(
                              (states) => RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ))),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final pb = context.watch<ProductBloc>();
    List<ProductsModel> bookmarkProductsList = pb.bookmarkedProductList;
    // print(bookmarkProductsList.length);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 250, 255),
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                _openCLearAllDialog(() {
                  pb.clearProductFromBookmark();
                  Navigator.pop(context);
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  'Clear all',
                  style: TextStyle(color: Colors.black),
                ),
              ))
        ],
        title: Text(
          'Bookmarks',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: bookmarkProductsList.isEmpty
          ? EmptyPageWithImage(
              image: Config.bookmarkImage,
              title: 'bookmark is empty',
              description: 'save your favourite product here',
            )
          : ListView.builder(
              itemCount: bookmarkProductsList.length,
              itemBuilder: ((context, index) {
                ProductsModel singleProduct = bookmarkProductsList[index];
                return Center(
                  child: Container(
                    width: 300,
                    child: Card1(
                      product: singleProduct,
                      thisProductList: bookmarkProductsList,
                    ),
                  ),
                );
              })),
    );
  }
}
// import 'package:hive/hive.dart';
// import 'package:quickshop_ecommerce/config/config.dart';
// import 'package:quickshop_ecommerce/constants/constants.dart';
// import 'package:quickshop_ecommerce/models/products_model.dart';

// class BookMarkTab extends StatefulWidget {
//   const BookMarkTab({super.key});

//   @override
//   State<BookMarkTab> createState() => _BookMarkTabState();
// }

// class _BookMarkTabState extends State<BookMarkTab> {
//   @override
//   Widget build(BuildContext context) {
//     final bookmarkList = Hive.box(Constants.bookmarkTag);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('bookmarks'),
//         automaticallyImplyLeading: false,

//         // actions: [
//         // TextButton(
//         //   onPressed: ()=> _openCLearAllDialog(),
//         //   child: Text('clear all'),
//         //   style: ButtonStyle(
//         //       padding: MaterialStateProperty.resolveWith(
//         //           (states) => EdgeInsets.only(right: 15, left: 15))),
//         // ),

//         // ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ValueListenableBuilder(
//                 valueListenable: ValueNotifier(0),
//                 builder: (BuildContext context, dynamic value, Widget? child) {
//                   if (bookmarkList.isEmpty) {
//                     return Center(child: Text('Empty'));
//                     // return EmptyPageWithImage(
//                     //   image: Config.bookmarkImage,
//                     //   title: 'bookmark is empty',
//                     //   description: 'save your favourite contents here'.tr(),
//                     // );
//                   }

//                   return ListView.separated(
//                     padding: EdgeInsets.all(15),
//                     itemCount: bookmarkList.length,
//                     separatorBuilder: (context, index) => SizedBox(
//                       height: 15,
//                     ),
//                     itemBuilder: (BuildContext context, int index) {
//                       ProductsModel product = ProductsModel(
//                         id: bookmarkList.getAt(index)['id'],
//                         name: bookmarkList.getAt(index)['name'],
//                         description: bookmarkList.getAt(index)['description'],
//                         image: bookmarkList.getAt(index)['image'],
//                         price: bookmarkList.getAt(index)['price'],
//                         status: '',
//                         isfavourite: true,
//                       );

//                       return Center(
//                         child: Text(product.name),
//                       );
//                     },
//                   );
//                 }),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   bool get wantKeepAlive => true;
// }
