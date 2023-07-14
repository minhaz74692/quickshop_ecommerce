import 'package:flutter/material.dart';

class Config {
  final String appName = 'QuickShop';
  // final String splashIcon = 'assets/images/splash.png';
  final String supportEmail = 'minhaz.ipe.sust@gmail.com';
  final String privacyPolicyUrl = 'https://minhaz74692.github.io/md.mie/';
  final String ourWebsiteUrl = 'https://minhaz74692.github.io/md.mie/';
  final String iOSAppId = '000000';

  //social links
  static const String facebookPageUrl = 'https://web.facebook.com/minhaz.74692';
  static const String twitterUrl = 'https://twitter.com/minhazul3666';
  static const String linkedinUrl =
      'https://www.linkedin.com/in/minhazul-islam-7ab09a192/';
  static const String githubUrl = 'https://github.com/minhaz74692';

  //app theme color

  final Color appColor = Colors.deepPurpleAccent;

  static const String bookmarkImage = "assets/images/bookmark.svg";

  //Intro images
  final String introImage1 = 'assets/images/news1.png';
  final String introImage2 = 'assets/images/news6.png';
  final String introImage3 = 'assets/images/news7.png';

  //animation files
  final String doneAsset = 'assets/animation_files/done.json';

  //Language Setup
  final List<String> languages = ['English', 'Spanish', 'Arabic'];

  //initial categories - 4 only (Hard Coded : which are added already on your admin panel)
  final List initialCategories = [
    'Sports',
    'Entertainment',
    'Business',
    'timestamp'
  ];
}
