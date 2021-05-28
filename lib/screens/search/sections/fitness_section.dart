import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:tryve/components/custom_clip_shape.dart';
import 'package:tryve/screens/search/search_slider.dart';
import 'package:tryve/services/api/parse/goal_api/goal_api.dart';

class FitnessSection extends StatefulWidget {
  FitnessSection({Key key}) : super(key: key);

  @override
  _FitnessSectionState createState() => _FitnessSectionState();
}

class _FitnessSectionState extends State<FitnessSection> {
  @override
  Widget build(BuildContext context) {
    return CustomClipShape(
      height: 260,
      appBarDivider: 2.6,
      heightAdder: 200,
      bottom: FutureBuilder(
        future: GoalAPI.getGoals("fitness"),
        builder: (context, AsyncSnapshot<ParseResponse> snapshot) {
          if (snapshot.hasData) {
            return ScreenSlider(
              name: "Fitness",
              style: titleStyle.copyWith(color: Colors.white),
              buttonStyle: buttonStyleBase.copyWith(color: Colors.white),
              data: snapshot.data.result,
            );
          } else {
            return ScreenSlider(
              name: "Fitness",
              style: titleStyle.copyWith(color: Colors.white),
              buttonStyle: buttonStyleBase.copyWith(color: Colors.white),
              data: [],
              loading: true,
            );
          }
        },
      ),
      bottomPos: 0.0,
    );
  }
}
