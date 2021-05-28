import 'package:flutter/material.dart';
import 'package:tryve/components/system_theme_wrapper.dart';
import 'package:tryve/screens/search/sections/adventures_section.dart';
import 'package:tryve/screens/search/sections/fitness_section.dart';
import 'package:tryve/screens/search/sections/languages_section.dart';
import 'package:tryve/screens/search/sections/lifestyle_section.dart';
import 'package:tryve/screens/search/sections/music_section.dart';

class Screen extends StatefulWidget {
  static String routeName = "/verify";
  Screen({Key key}) : super(key: key);

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SystemThemeWrapper(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FitnessSection(),
            LifeStyleSection(),
            AdventureSection(),
            LanguagesSection(),
            MusicSection(),
          ],
        ),
      ),
    ));
  }
}
