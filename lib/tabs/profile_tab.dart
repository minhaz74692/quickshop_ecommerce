// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:quickshop_ecommerce/config/config.dart';
import 'package:quickshop_ecommerce/providers/auth.dart';
import 'package:quickshop_ecommerce/screens/login.dart';
import 'package:quickshop_ecommerce/screens/welcome_page.dart';
import 'package:quickshop_ecommerce/services/app_service.dart';
import 'package:quickshop_ecommerce/utils/nextscreen.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _Settingscreenstate();
}

class _Settingscreenstate extends State<ProfileTab>
    with AutomaticKeepAliveClientMixin {
//   void openLicenceDialog() {
//     showDialog(
//         context: context,
//         builder: (_) {
//           return AboutDialog(
//             applicationName: Config().appName,
//             applicationIcon: Image(
//               image: AssetImage(Config.splash),
//               height: 30,
//               width: 30,
//             ),
//           );
//         });
//   }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ub = context.watch<FirebaseAuthBloc>();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 140,
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title: Text(
                'settings',
                style: TextStyle(color: Colors.white),
              ),
              titlePadding: EdgeInsets.only(left: 20, bottom: 20, right: 20),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                top: 15,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary),
                    child: !ub.isSignedIn ? GuestUserUI() : UserUI(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'general settings',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.7,
                              wordSpacing: 1),
                        ),
                        SizedBox(height: 15),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            radius: 18,
                            child: Icon(
                              Feather.bell,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            'get notifications',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          trailing: Switch.adaptive(
                            activeColor: Theme.of(context).primaryColor,
                            //TODO value: context.watch<NotificationBloc>().subscribed,
                            // onChanged: (bool value) => context
                            //     .read<NotificationBloc>()
                            //     .handleSubscription(context, value),
                            value: true,
                            onChanged: (value) {},
                          ),
                        ),
                        _Divider(),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueGrey,
                            radius: 18,
                            child: Icon(
                              Icons.wb_sunny,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            'dark mode',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          trailing: Switch.adaptive(
                              activeColor: Theme.of(context).primaryColor,
                              // value: context.watch<ThemeBloc>().darkTheme!,
                              value: false,
                              onChanged: (bool) {
                                // context.read<ThemeBloc>().toggleTheme();
                              }),
                        ),
                        _Divider(),
                        ListTile(
                            contentPadding: EdgeInsets.all(0),
                            leading: CircleAvatar(
                              backgroundColor: Colors.purpleAccent,
                              radius: 18,
                              child: Icon(
                                Feather.globe,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              'language',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            trailing: Icon(Feather.chevron_right),
                            onTap: () {
                              // nextScreenPopup(context, LanguagePopup());
                            }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'about app',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.7,
                              wordSpacing: 1),
                        ),
                        SizedBox(height: 15),
                        ListTile(
                            contentPadding: EdgeInsets.all(0),
                            leading: CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              radius: 18,
                              child: Icon(
                                Feather.lock,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              'privacy policy',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            trailing: Icon(Feather.chevron_right),
                            onTap: () {
                              // AppService().openLinkWithCustomTab(context, Config.privacyPolicyUrl);
                            }),
                        _Divider(),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: CircleAvatar(
                            backgroundColor: Colors.pinkAccent,
                            radius: 18,
                            child: Icon(
                              Feather.star,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            'rate this app',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          trailing: Icon(Feather.chevron_right),
                          // onTap: () => AppService().launchAppReview(context),
                          onTap: () {},
                        ),
                        _Divider(),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: CircleAvatar(
                            backgroundColor: Colors.orangeAccent,
                            radius: 18,
                            child: Icon(
                              Feather.lock,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            'licence',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          trailing: Icon(Feather.chevron_right),
                          // onTap: () => openLicenceDialog(),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'social settings',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.7,
                              wordSpacing: 1),
                        ),
                        SizedBox(height: 15),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: CircleAvatar(
                            backgroundColor: Colors.redAccent[100],
                            radius: 18,
                            child: Icon(
                              Feather.mail,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            'contact us',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          trailing: Icon(Feather.chevron_right),
                          onTap: () => AppService().openEmailSupport(context),
                        ),
                        _Divider(),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            radius: 18,
                            child: Icon(
                              Feather.link,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            'our website',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          trailing: Icon(Feather.chevron_right),
                          // onTap: () => AppService().openLinkWithCustomTab(
                          //     context, WpConfig.websiteUrl),
                          onTap: () {},
                        ),
                        _Divider(),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            radius: 18,
                            child: Icon(
                              Feather.facebook,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            'facebook page',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          trailing: Icon(Feather.chevron_right),
                          onTap: () => AppService()
                              .openLink(context, Config.facebookPageUrl),
                        ),
                        _Divider(),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: CircleAvatar(
                            backgroundColor: Colors.redAccent,
                            radius: 18,
                            child: Icon(
                              Feather.github,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            'github profile',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          trailing: Icon(Feather.chevron_right),
                          onTap: () =>
                              AppService().openLink(context, Config.githubUrl),
                        ),
                        _Divider(),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 18,
                            child: Icon(
                              Feather.twitter,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            'twitter',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          trailing: Icon(Feather.chevron_right),
                          onTap: () =>
                              AppService().openLink(context, Config.twitterUrl),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: ub.isSignedIn,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        _SecurityOption(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _SecurityOption extends StatelessWidget {
  const _SecurityOption({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.onPrimary),
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        isThreeLine: false,
        leading: CircleAvatar(
          backgroundColor: Colors.redAccent,
          radius: 20,
          child: Icon(
            Feather.settings,
            size: 20,
            color: Colors.white,
          ),
        ),
        title: Text(
          'security',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        trailing: Icon(Feather.chevron_right),
        // onTap: () => nextScreen(context, SecurityPage()),
        onTap: () {},
      ),
    );
  }
}

class GuestUserUI extends StatelessWidget {
  const GuestUserUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            radius: 18,
            child: Icon(
              Feather.user_plus,
              size: 18,
              color: Colors.white,
            ),
          ),
          title: Text(
            'login',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          trailing: Icon(Feather.chevron_right),
          onTap: () => nextScreenPopup(context, LogIn()),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 0.0,
      thickness: 0.2,
      indent: 50,
      color: Colors.grey[400],
    );
  }
}

class UserUI extends StatelessWidget {
  const UserUI({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuthBloc ub = context.watch<FirebaseAuthBloc>();
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            radius: 18,
            child: Icon(
              Feather.user_check,
              size: 18,
              color: Colors.white,
            ),
          ),
          title: Text(
            ub.name ?? 'Admin',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
        _Divider(),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: CircleAvatar(
            backgroundColor: Colors.indigoAccent[100],
            radius: 18,
            child: Icon(
              Feather.mail,
              size: 18,
              color: Colors.white,
            ),
          ),
          title: Text(
            ub.email!,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
        _Divider(),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: CircleAvatar(
            backgroundColor: Colors.redAccent[100],
            radius: 18,
            child: Icon(
              Feather.log_out,
              size: 18,
              color: Colors.white,
            ),
          ),
          title: Text(
            'logout',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          trailing: Icon(Feather.chevron_right),
          onTap: () => openLogoutDialog(context),
        ),
      ],
    );
  }

  openLogoutDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('logout description'),
            title: Text('logout title'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    _handleLogout(context);
                  },
                  child: Text('logout')),
            ],
          );
        });
  }

  Future _handleLogout(context) async {
    final FirebaseAuthBloc ub =
        Provider.of<FirebaseAuthBloc>(context, listen: false);
    await ub
        .signOut()
        .then((value) => nextScreenCloseOthers(context, WelcomePage()));
  }
}
