import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tryve/helpers/platform_helper.dart';
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
    if (isDesktop()) {
      int _selectedIndex = 0;
    
      return Scaffold(
        body: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                // TODO: embed the logo in a square box 65/384 of screen width
                SvgPicture.asset(
                  'images/logo_big.svg',
                  width: MediaQuery.of(context).size.width * 25/384,
                ),
                Expanded(
                  child: NavigationRail(
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: (int index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    
                      _controller.animateTo(index);
                    },
                    labelType: NavigationRailLabelType.selected,
                    destinations: [
                      NavigationRailDestination(
                        icon: ImageIcon(
                          AssetImage('images/sidebar/home.png'),
                        ),
                        selectedIcon: ImageIcon(
                          AssetImage('images/sidebar/home_selected.png'),
                        ),
                        label: Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(PhosphorIcons.magnifying_glass),
                        // TODO: make a gradiented search icon
                        selectedIcon: Icon(PhosphorIcons.magnifying_glass),
                        label: Text('Feed'),
                      ),
                      NavigationRailDestination(
                        icon: ImageIcon(
                          AssetImage('images/sidebar/verify.png'),
                        ),
                        selectedIcon: ImageIcon(
                          AssetImage('images/sidebar/verify_selected.png'),
                        ),
                        label: Text('Verify'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(PhosphorIcons.rss),
                        // TODO: make a gradiented feed icon
                        selectedIcon: Icon(PhosphorIcons.rss),
                        label: Text('Feed'),
                      ),
                      NavigationRailDestination(
                        icon: ImageIcon(
                          AssetImage('images/sidebar/profile.png'),
                        ),
                        selectedIcon: ImageIcon(
                          AssetImage('images/sidebar/profile_selected.png'),
                        ),
                        label: Text('Profile'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: _screens,
                controller: _controller,
              ),
            ),
          ],
        ),
      );
    }
  
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
              icon: Icon(PhosphorIcons.house), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.magnifying_glass), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.camera), label: "Verify"),
          BottomNavigationBarItem(icon: Icon(PhosphorIcons.rss), label: "Feed"),
          BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.user_circle), label: "Profile")
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
