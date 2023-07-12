// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
// import 'package:quickshop_ecommerce/blocs/sign_in_bloc.dart';
// import 'package:quickshop_ecommerce/blocs/theme_bloc.dart';
import 'package:quickshop_ecommerce/config/config.dart';
import 'package:quickshop_ecommerce/providers/auth.dart';
import 'package:quickshop_ecommerce/services/app_service.dart';
import 'package:quickshop_ecommerce/tabs/profile_tab.dart';
// import 'package:quickshop_ecommerce/models/custom_color.dart';
// import 'package:quickshop_ecommerce/pages/bookmarks.dart';
// import 'package:quickshop_ecommerce/services/app_service.dart';
import 'package:quickshop_ecommerce/utils/app_name.dart';
import 'package:quickshop_ecommerce/utils/nextscreen.dart';
// import 'package:quickshop_ecommerce/widgets/language.dart';
// import 'package:easy_localization/easy_localization.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final sb = context.watch<SignInBloc>();
    final List titles = [
      'bookmarks',
      'language',
      'about us',
      'privacy policy',
      'contact us',
      'facebook',
      'linkedin',
      'github',
      'twitter',
      'settings',
    ];

    final List icons = [
      Feather.bookmark,
      Feather.globe,
      Feather.info,
      Feather.lock,
      Feather.mail,
      Feather.facebook,
      Feather.linkedin,
      Feather.github,
      Feather.twitter,
      Feather.settings,
    ];
    final ub = context.watch<FirebaseAuthBloc>();
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            DrawerHeader(
              child: Container(
                alignment: Alignment.center,
                //color: context.watch<ThemeBloc>().darkTheme == false ? CustomColor().drawerHeaderColorLight : CustomColor().drawerHeaderColorDark,
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppName(fontSize: 25.0),
                    Text(
                      'Version: 1.0.1',
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                    //TODO: Text('Version: ${sb.appVersion}', style: TextStyle(
                    //   fontSize: 13, color: Colors.grey[600]
                    // ),),
                  ],
                ),
              ),
            ),
            SizedBox(
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 30),
                itemCount: titles.length,
                shrinkWrap: true,
                separatorBuilder: (ctx, idx) => Divider(
                  height: 0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      titles[index],
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    leading: CircleAvatar(
                        radius: 20,
                        // backgroundColor: context.watch<ThemeBloc>().darkTheme == false ? CustomColor().drawerHeaderColorLight : CustomColor().drawerHeaderColorDark,
                        backgroundColor: Colors.white,
                        child: Icon(
                          icons[index],
                          color: Colors.grey[600],
                        )),
                    onTap: () async {
                      Navigator.pop(context);
                      if (index == 0) {
                        // nextScreen(context, BookmarkPage());
                      } else if (index == 1) {
                        // nextScreenPopup(context, LanguagePopup());
                      } else if (index == 2) {
                        AppService().openLinkWithCustomTab(
                            context, Config().ourWebsiteUrl);
                      } else if (index == 3) {
                        AppService().openLinkWithCustomTab(
                            context, Config().privacyPolicyUrl);
                      } else if (index == 4) {
                        AppService().openEmailSupport(context);
                      } else if (index == 5) {
                        AppService().openLink(context, Config.facebookPageUrl);
                      } else if (index == 6) {
                        AppService().openLink(context, Config.linkedinUrl);
                      } else if (index == 7) {
                        AppService().openLink(context, Config.githubUrl);
                      } else if (index == 8) {
                        AppService().openLink(context, Config.twitterUrl);
                      } else if (index == 9) {
                        print(ub.email);
                        nextScreen(
                          context,
                          ProfileTab(),
                        );
                      }
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
