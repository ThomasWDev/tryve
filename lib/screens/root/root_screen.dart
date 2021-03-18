import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:tryve/screens/feed/feed_screen.dart';
import 'package:tryve/screens/home/home_screen.dart';
import 'package:tryve/screens/profile/profile_screen.dart';
import 'package:tryve/screens/search/search_screen.dart';
import 'package:tryve/screens/verify/verify_screen.dart';
import 'package:tryve/theme/palette.dart';

class RootScreen extends StatefulWidget {
  static String routeName = "/root";
  RootScreen({Key key}) : super(key: key);

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen>
    with SingleTickerProviderStateMixin {
  int index = 0;
  List<Widget> _screens;
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _genScreens();
    _controller = TabController(length: _screens.length, vsync: this);

    _controller.addListener(() {
      if (_controller.indexIsChanging) {
        setState(() {
          index = _controller.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _genScreens() {
    _screens = [
      HomeScreen(),
      SearchScreen(),
      VerifyScreen(),
      FeedScreen(),
      ProfileScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: _screens,
        controller: _controller,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 10.0,
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.house), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.magnifying_glass),
              title: Text("Search")),
          BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.camera), title: Text("Verify")),
          BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.rss), title: Text("Feed")),
          BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.user_circle), title: Text("Profile"))
        ],
        showUnselectedLabels: true,
        selectedItemColor: Palette.primary,
        unselectedItemColor: Colors.grey,
        onTap: (int _index) {
          setState(() {
            index = _index;
          });

          _controller.animateTo(index);
        },
      ),
    );
  }
}
