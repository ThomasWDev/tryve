import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:tryve/services/api/parse/goal_api/goal_api.dart';

import '../search_slider.dart';

class MusicSection extends StatelessWidget {
  const MusicSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GoalAPI.getGoals("music"),
      builder: (context, AsyncSnapshot<ParseResponse> snapshot) {
        if (snapshot.hasData) {
          return ScreenSlider(
            name: "Music",
            data: snapshot.data.result,
          );
        } else {
          return ScreenSlider(
            name: "Music",
            data: [],
            loading: true,
          );
        }
      },
    );
  }
}
