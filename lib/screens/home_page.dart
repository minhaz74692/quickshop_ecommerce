// ignore_for_file: library_private_types_in_public_api, prefer_final_fields, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:quickshop_ecommerce/screens/cart.dart';
import 'package:quickshop_ecommerce/tabs/home_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens = <Widget>[
    HomeTab(),
    SearchPage(),
    NotificationsPage(),
    ProfilePage(),
  ];
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.search),
        title: ("Search"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.shopping_cart),
        title: ("My Cart"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.settings),
        title: ("Settings"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  int selectedIndex = 0;
  PageController? _pageController;
  Future _onWillPop() async {
    if (selectedIndex != 0) {
      setState(() => selectedIndex = 0);
      _pageController!.animateToPage(0,
          duration: Duration(milliseconds: 200), curve: Curves.easeIn);
    } else {
      await SystemChannels.platform
          .invokeMethod<void>('SystemNavigator.pop', true);
    }
  }

  @override
  void initState() {
    // TODO: implement initState_pageController = PageController();
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await _onWillPop(),
      child: Scaffold(
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens,
          items: _navBarsItems(),
          confineInSafeArea: true,
          // backgroundColor: Color.fromARGB(255, 230, 233, 238),
          backgroundColor: Colors.white,
          // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset:
              true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows:
              true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: Colors.white,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: ItemAnimationProperties(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle
              .style1, // Choose the nav bar style with this property.
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Center(
        child: Text('Search Page'),
      ),
    );
  }
}

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Center(
        child: Text('Notifications Page'),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Text('Profile Page'),
      ),
    );
  }
}
