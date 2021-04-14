import 'package:flutter/material.dart';
import 'package:tryve/components/auth_button.dart';
import 'package:tryve/components/custom_clip_shape.dart';
import 'package:tryve/components/system_theme_wrapper.dart';
import 'package:tryve/helpers/nav_helper.dart';
import 'package:tryve/screens/verify/congratulate_screen.dart';
import 'package:tryve/services/api/mock.dart';
import 'package:tryve/theme/palette.dart';

class AuthenticationMethodScreen extends StatefulWidget {
  static String routeName = "/auth_method_screen";
  AuthenticationMethodScreen({Key key}) : super(key: key);

  @override
  _AuthenticationMethodScreenState createState() =>
      _AuthenticationMethodScreenState();
}

class _AuthenticationMethodScreenState
    extends State<AuthenticationMethodScreen> {
  Widget _header() {
    return CustomClipShape(
      heightAdder: 40,
      childDivider: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Column(
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: AuthenticationMehodMocks.images
                  .map(
                    (image) => Container(
                      width: 120,
                      height: 110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          image: DecorationImage(
                              image: NetworkImage(
                                image,
                              ),
                              fit: BoxFit.cover)),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: AuthButton(
                  height: 50,
                  onPressed: () => replacePage(
                      newPage: CongratulateScreen.routeName, context: context),
                  label: "View all past authentication shots",
                  style: TextStyle(
                      color: Palette.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  Widget _bodyHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Authentication Method",
          style: TextStyle(
              color: Palette.primary,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          color: Colors.grey.withOpacity(0.3),
          child: Text("B/08 / 8-B / Z1 / L"),
        )
      ],
    );
  }

  Widget _bodyContent() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Text(
        AuthenticationMehodMocks.bodyText,
        style: TextStyle(color: Palette.darkTextShade1),
      ),
    );
  }

  Widget _bodyFooter() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          AuthenticationMehodMocks.footerText,
          style: TextStyle(color: Palette.darkTextShade1),
        ),
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          _bodyHeader(),
          _bodyContent(),
          Divider(
            color: Colors.grey,
          ),
          _bodyFooter()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SystemThemeWrapper(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [_header(), _body()],
        ),
      ),
    ));
  }
}
