// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class LoadingFeaturedCard extends StatelessWidget {
  const LoadingFeaturedCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
        child: Container(
            margin: EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                // color: context.watch<ThemeBloc>().darkTheme == false ? CustomColor().loadingColorLight : CustomColor().loadingColorDark,
                color: Color.fromARGB(255, 243, 239, 239),
                borderRadius: BorderRadius.circular(5))));
  }
}

class LoadingCard extends StatelessWidget {
  final double? height;
  const LoadingCard({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: SkeletonAnimation(
        child: Container(
          decoration: BoxDecoration(
              // color: context.watch<ThemeBloc>().darkTheme == false ? CustomColor().loadingColorLight : CustomColor().loadingColorDark,
              color: Color.fromARGB(255, 243, 239, 239),
              borderRadius: BorderRadius.circular(5)),
          height: height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
