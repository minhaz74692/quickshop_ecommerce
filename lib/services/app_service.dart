// ignore_for_file: prefer_const_constructors, library_prefixes

import 'package:flutter/material.dart';
import 'package:quickshop_ecommerce/config/config.dart';
import 'package:quickshop_ecommerce/utils/toast.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AppService {
  Future openLink(context, String url) async {
    final uri = Uri.parse(url);
    try {
      urlLauncher.launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      openToast1(context, "Can't launch the url");
    }
    // if (await urlLauncher.canLaunchUrl(uri)) {
    //   urlLauncher.launchUrl(uri, mode: LaunchMode.externalApplication);
    // } else {
    //   openToast1(context, "Can't launch the url");
    // }
  }

  Future openEmailSupport(context) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: Config().supportEmail,
      query:
          'subject=About ${Config().appName}&body=', //add subject and body here
    );
    try {
      urlLauncher.launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      openToast1(context, "Can't launch the url");
    }

    // if (await urlLauncher.canLaunchUrl(uri)) {
    //   await urlLauncher.launchUrl(uri,mode: LaunchMode.externalApplication);
    // } else {
    //   openToast1(context, "Can't open the email app");
    // }
  }

  Future openLinkWithCustomTab(BuildContext context, String url) async {
    try {
      await FlutterWebBrowser.openWebPage(
        url: url,
        customTabsOptions: CustomTabsOptions(
          // colorScheme: context.read<ThemeBloc>().darkTheme!
          //     ? CustomTabsColorScheme.dark
          //     : CustomTabsColorScheme.light,
          //addDefaultShareMenuItem: true,
          instantAppsEnabled: true,
          showTitle: true,
          urlBarHidingEnabled: true,
        ),
        safariVCOptions: SafariViewControllerOptions(
          barCollapsingEnabled: true,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
          modalPresentationCapturesStatusBarAppearance: true,
        ),
      );
    } catch (e) {
      openToast1(context, 'Cant launch the url');
      debugPrint(e.toString());
    }
  }
}
