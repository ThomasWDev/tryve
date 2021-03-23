import 'package:flutter/material.dart';
import 'package:tryve/components/custom_clip_shape.dart';
import 'package:tryve/components/system_theme_wrapper.dart';
import 'package:tryve/screens/verify/very_slider.dart';

class VerifyScreen extends StatefulWidget {
  static String routeName = "/verify";
  VerifyScreen({Key key}) : super(key: key);

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return SystemThemeWrapper(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomClipShape(
              height: 260,
              appBarDivider: 2.6,
              heightAdder: 200,
              bottom: VerifyScreenSlider(
                name: "Fitness",
                style: titleStyle.copyWith(color: Colors.white),
                buttonStyle: buttonStyleBase.copyWith(color: Colors.white),
              ),
              bottomPos: 0.0,
            ),
            VerifyScreenSlider(
              name: "Lifestyle",
            ),
            VerifyScreenSlider(
              name: "Adventures",
            ),
            VerifyScreenSlider(
              name: "Mindfulness",
            ),
            VerifyScreenSlider(
              name: "Fashion",
            ),
          ],
        ),
      ),
    ));
  }
}
