import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:tryve/components/auth_button.dart';
import 'package:tryve/components/common_avatar.dart';
import 'package:tryve/components/custom_clip_shape.dart';
import 'package:tryve/services/api/mock.dart';
import 'package:tryve/theme/palette.dart';

class UpcomingChallengesScreen extends StatelessWidget {
  static String routeName = "/upcoming_challenges";
  const UpcomingChallengesScreen({Key key}) : super(key: key);

  Widget _coloredHeader() {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Palette.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Drink water daily",
              style: TextStyle(color: Colors.white, fontSize: 22)),
          Text("Starts : 12/15/2021",
              style: TextStyle(color: Colors.white, fontSize: 18)),
        ],
      ),
    );
  }

  Widget _textualContent() {
    final TextStyle style = TextStyle(
      color: Palette.darkTextShade1,
      fontSize: 15,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Text(
            UpComingChallengeMock.headerText,
            style: style,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            UpComingChallengeMock.body,
            style: style,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            UpComingChallengeMock.footerText,
            style: style,
          ),
        ],
      ),
    );
  }

  Widget _methodView({
    bool right = true,
  }) {
    return Stack(
      children: [
        CommonAvatar(
          radius: 60,
          showBorder: false,
        ),
        CircleAvatar(
          backgroundColor: Colors.black.withOpacity(0.4),
          radius: 60,
        ),
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 60,
          child: Center(
            child: right
                ? Icon(
                    PhosphorIcons.check,
                    color: Colors.green,
                    size: 60,
                  )
                : Icon(
                    PhosphorIcons.x,
                    color: Colors.red,
                    size: 60,
                  ),
          ),
        ),
      ],
    );
  }

  Widget _verificationMethodView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Text(
            "Verification Methods",
            style: TextStyle(
                color: Palette.primary,
                fontSize: 26,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _methodView(),
              _methodView(right: false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _input() {
    return _Input();
  }

  Widget _btn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: AuthButton(
        onPressed: () {},
        label: "Submit",
        color: Palette.primary,
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      height: 630,
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0.0, 8.0),
                blurRadius: 40)
          ]),
      child: Column(
        children: [
          _coloredHeader(),
          SizedBox(
            height: (630 - 120).toDouble(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _textualContent(),
                _verificationMethodView(),
                _input(),
                _btn()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return CustomClipShape(
      childDivider: 1,
      heightAdder: 500,
      fillHeight: true,
      showLeading: true,
      child: _body(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [_header(context)],
        ),
      ),
    );
  }
}

class _Input extends StatelessWidget {
  const _Input({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(100.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        children: <Widget>[
          Icon(PhosphorIcons.currency_dollar, size: 20),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter between \$10 - \$50 to join",
                  hintStyle: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
