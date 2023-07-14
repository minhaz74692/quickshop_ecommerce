// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyPageWithImage extends StatelessWidget {
  const EmptyPageWithImage({
    Key? key,
    required this.image,
    required this.title,
    this.description,
  }) : super(key: key);

  final String image;
  final String title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(50),
      alignment: Alignment.center,
      //height: MediaQuery.of(context).size.height * 0.60,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image,
            fit: BoxFit.contain,
            alignment: Alignment.center,
            height: 180,
            width: 180,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          description == null
              ? Container()
              : Text(
                  description!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                      fontSize: 16),
                )
        ],
      ),
    );
  }
}
