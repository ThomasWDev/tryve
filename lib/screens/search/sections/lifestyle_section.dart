import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:tryve/services/api/parse/goal_api/goal_api.dart';

import '../search_slider.dart';

class LifeStyleSection extends StatelessWidget {
  const LifeStyleSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GoalAPI.getGoals("lifestyle"),
      builder: (context, AsyncSnapshot<ParseResponse> snapshot) {
        if (snapshot.hasData) {
          return ScreenSlider(
            name: "LifeStyle",
            data: snapshot.data.result,
          );
        } else {
          return ScreenSlider(
            name: "LifeStyle",
            data: [],
            loading: true,
          );
        }
      },
    );
  }
}
