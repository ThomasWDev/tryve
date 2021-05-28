import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:tryve/components/common_avatar.dart';
import 'package:tryve/components/custom_clip_shape.dart';
import 'package:tryve/helpers/nav_helper.dart';
import 'package:tryve/screens/root/root_screen.dart';
import 'package:tryve/theme/palette.dart';
import 'package:tryve/theme/theme.dart';

class CongratulateScreen extends StatelessWidget {
  static String routeName = "/congratulate_screen";
  const CongratulateScreen({Key key}) : super(key: key);

  Widget _baseReward({String label, String value}) {
    return CircleAvatar(
      radius: 58,
      backgroundColor: Palette.primary,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 22, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  Widget _rewards(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _baseReward(label: "Success Rate", value: "100%"),
        _baseReward(label: "Reward", value: "+\$25"),
        _baseReward(label: "Acheivement", value: "150km")
      ],
    );
  }

  Widget _bar() {
    return SizedBox(
      height: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: LinearProgressIndicator(
          backgroundColor: Colors.grey.withOpacity(0.2),
          value: .7,
          valueColor: AlwaysStoppedAnimation(Palette.primary),
        ),
      ),
    );
  }

  Widget _footer() {
    return Column(
      children: [
        Text(
          "You did it ! You beat the odds.",
          style: commonBoldStyle.copyWith(
              fontSize: 20, color: Colors.black.withOpacity(0.8)),
        ),
        Text("Now it's time for your reward.",
            style: commonBoldStyle.copyWith(
                fontSize: 20, color: Colors.black.withOpacity(0.8)))
      ],
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      height: 600,
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 22.0),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Congratulations !",
            style: commonBoldStyle.copyWith(
                fontSize: 30,
                color: Palette.primary,
                fontWeight: FontWeight.w600),
          ),
          CommonAvatar(),
          Text("\$250",
              style: commonBoldStyle.copyWith(
                  fontSize: 30, fontWeight: FontWeight.w600)),
          _rewards(context),
          _bar(),
          _footer()
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
      leading: IconButton(
        icon: Icon(
          PhosphorIcons.caret_left,
          color: Colors.white,
        ),
        onPressed: () => pushPageWhileRemove(
            newPage: RootScreen.routeName, context: context),
      ),
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
