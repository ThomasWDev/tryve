import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:tryve/helpers/toast_helper.dart';
import 'package:tryve/screens/feed/feed_screen.dart';
import 'package:tryve/screens/home/home_screen.dart';
import 'package:tryve/screens/profile/profile_screen.dart';
import 'package:tryve/screens/search/search_screen.dart';
import 'package:tryve/services/api/parse/user_api/user_api.dart';
import 'package:tryve/state/feed_state.dart';
import 'package:tryve/state/goals_state.dart';
import 'package:tryve/theme/palette.dart';
import 'package:provider/provider.dart';

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
    _checkValidity();
    context.read<GoalState>().fetchGoals();
    context.read<FeedState>().fetchGoals();

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

  void _checkValidity() async {
    final _auth = FirebaseAuth.instance;
    if (_auth.currentUser != null) {
      if ((await UserAPI.getUserbyMail(_auth.currentUser.email)).result ==
          null) {
        await _auth.signOut();
        toast("Account doesn't exist");
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _genScreens() {
    _screens = [HomeScreen(), Screen(), FeedScreen(), ProfileScreen()];
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
              icon: Icon(PhosphorIcons.house), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.magnifying_glass), label: "Search"),
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
