import 'package:flutter/material.dart';
import 'package:tryve/screens/auth/auth_root.dart';
import 'package:tryve/screens/auth/reset_pass_screen.dart';
import 'package:tryve/screens/chat/chat_screen.dart';
import 'package:tryve/screens/feed/feed_screen.dart';
import 'package:tryve/screens/home/home_screen.dart';
import 'package:tryve/screens/loading/loading_screen.dart';
import 'package:tryve/screens/message/message_screen.dart';
import 'package:tryve/screens/profile/customize_profile/customize_profile_screen.dart';
import 'package:tryve/screens/profile/profile_screen.dart';
import 'package:tryve/screens/root/root_screen.dart';
import 'package:tryve/screens/search/authentication_method_screen.dart';
import 'package:tryve/screens/search/complete_verification_screen.dart';
import 'package:tryve/screens/search/congratulate_screen.dart';
import 'package:tryve/screens/search/search_screen.dart';
import 'package:tryve/screens/search/write_post_screen.dart';
import 'package:tryve/services/auth/auth_layer_screen.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  RootScreen.routeName: (context) => RootScreen(),
  LoadingScreen.routeName: (context) => LoadingScreen(),
  AuthRootScreen.routeName: (context) => AuthRootScreen(),
  Screen.routeName: (context) => Screen(),
  FeedScreen.routeName: (context) => FeedScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  AuthLayerScreen.routeName: (context) => AuthLayerScreen(),
  MessageScreen.routeName: (context) => MessageScreen(),
  WritePostScreen.routeName: (context) => WritePostScreen(),
  CongratulateScreen.routeName: (context) => CongratulateScreen(),
  CustomizeProfileScreen.routeName: (context) => CustomizeProfileScreen(),
  ResetPasswordScreen.routeName: (context) => ResetPasswordScreen(),
  ChatScreen.routeName: (context) => ChatScreen(),
  AuthenticationMethodScreen.routeName: (context) =>
      AuthenticationMethodScreen(),
  CompleteVerificationScreen.routeName: (context) =>
      CompleteVerificationScreen(),
};
