import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:tryve/components/auth_button.dart';
import 'package:tryve/components/common_avatar.dart';
import 'package:tryve/components/common_loading_overlay.dart';
import 'package:tryve/components/custom_clip_shape.dart';
import 'package:tryve/helpers/nav_helper.dart';
import 'package:tryve/helpers/string_helpers.dart';
import 'package:tryve/helpers/toast_helper.dart';
import 'package:tryve/theme/palette.dart';
import 'package:flutter/services.dart';

class UpcomingChallengesScreen extends StatefulWidget {
  static String routeName = "/upcoming_challenges";

  final dynamic goal;

  UpcomingChallengesScreen({
    Key key,
    @required this.goal,
  }) : super(key: key);

  @override
  _UpcomingChallengesScreenState createState() =>
      _UpcomingChallengesScreenState();
}

class _UpcomingChallengesScreenState extends State<UpcomingChallengesScreen> {
  bool _loading = false;
  final TextEditingController _controller = TextEditingController();

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
          Text(widget.goal['title'],
              style: TextStyle(color: Colors.white, fontSize: 22)),
          Text(
              "Starts : ${StringHelpers.formatDate(widget.goal['startDate'] as DateTime)}",
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
            "Welcome to the newest challenge offered by Tryve .",
            style: style,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            widget.goal['description'],
            style: style,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "This challenge will go on for ${StringHelpers.dateDiff(widget.goal['startDate'] as DateTime, widget.goal['endDate'] as DateTime)} days",
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
    return _Input(
      controller: _controller,
    );
  }

  void _submit() async {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _loading = true;
      });

      final amount = num.tryParse(_controller.text);
      final _goal = ParseObject("Goal")
        ..objectId = widget.goal['objectId']
        ..set("verified", true)
        ..set(
          "amountPaid",
          amount ?? 0,
        );

      final response = await _goal.save();

      setState(() {
        _loading = false;
      });

      if (response.success) {
        toast("Goal verified");
      } else {
        toast("Couldn't verify goal !");
      }

      pop(context);
    } else {
      toast("Please enter a valid amount");
    }
  }

  Widget _btn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: AuthButton(
        onPressed: _submit,
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
      body: CommonLoadingOverlay(
        loading: _loading,
        child: SingleChildScrollView(
          child: Column(
            children: [_header(context)],
          ),
        ),
      ),
    );
  }
}

class _Input extends StatelessWidget {
  final TextEditingController controller;
  const _Input({Key key, @required this.controller}) : super(key: key);

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
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
