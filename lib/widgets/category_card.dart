// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quickshop_ecommerce/models/categories_model.dart';
import 'package:quickshop_ecommerce/screens/category_view.dart';
import 'package:quickshop_ecommerce/utils/nextscreen.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {super.key,
      required this.imageName,
      required this.imageUrl,
      required this.categoryModel});
  final String imageName;
  final String imageUrl;
  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        nextScreen(
            context,
            CategoryView(
              categoryModel: categoryModel,
            ));
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // shadow color
                  spreadRadius: 2, // spread radius
                  blurRadius: 5, // blur radius
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
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
  }
}
