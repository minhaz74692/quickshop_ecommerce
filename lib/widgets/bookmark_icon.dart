// ignore_for_file: prefer_if_null_operators, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quickshop_ecommerce/models/products_model.dart';
import 'package:quickshop_ecommerce/services/bookmark_service.dart';

class BookmarkIcon extends StatelessWidget {
  const BookmarkIcon(
      {Key? key,
      required this.bookmarkedList,
      required this.product,
      required this.iconSize,
      this.iconColor,
      this.normalIconColor})
      : super(key: key);

  final Box bookmarkedList;
  final ProductsModel? product;
  final double iconSize;
  final Color? iconColor;
  final Color? normalIconColor;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> countNotifier = ValueNotifier(0);
    return ValueListenableBuilder(
      valueListenable: countNotifier,
      builder: (context, dynamic value, Widget? child) {
        return IconButton(
            iconSize: iconSize,
            padding: EdgeInsets.all(0),
            constraints: BoxConstraints(),
            alignment: Alignment.centerRight,
            icon: bookmarkedList.keys.contains(product!.id)
                ? Icon(Icons.favorite,
                    color: iconColor == null ? Colors.pinkAccent : iconColor)
                : Icon(Icons.favorite_border,
                    color: normalIconColor == null
                        ? Colors.grey
                        : normalIconColor),
            onPressed: () {
              BookmarkService().handleBookmarkIconPressed(product!, context);
              countNotifier.value += 1;
            });
      },
    );
  }
}
