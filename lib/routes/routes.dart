import 'package:flutter/material.dart';
import 'package:tryve/screens/auth/auth_root.dart';
import 'package:tryve/screens/feed/feed_screen.dart';
import 'package:tryve/screens/home/home_screen.dart';
import 'package:tryve/screens/loading/loading_screen.dart';
import 'package:tryve/screens/profile/profile_screen.dart';
import 'package:tryve/screens/root/root_screen.dart';
import 'package:tryve/screens/search/search_screen.dart';
import 'package:tryve/screens/verify/verify_screen.dart';
import 'package:tryve/services/auth/auth_layer_screen.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  RootScreen.routeName: (context) => RootScreen(),
  LoadingScreen.routeName: (context) => LoadingScreen(),
  AuthRootScreen.routeName: (context) => AuthRootScreen(),
  SearchScreen.routeName: (context) => SearchScreen(),
  VerifyScreen.routeName: (context) => VerifyScreen(),
  FeedScreen.routeName: (context) => FeedScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  AuthLayerScreen.routeName: (context) => AuthLayerScreen(),
};
