import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:tryve/components/common_avatar.dart';
import 'package:tryve/components/common_loader.dart';
import 'package:tryve/components/custom_clip_shape.dart';
import 'package:tryve/components/system_theme_wrapper.dart';
import 'package:tryve/helpers/nav_helper.dart';
import 'package:tryve/screens/profile/customize_profile/customize_profile_screen.dart';
import 'package:tryve/screens/profile/profile_menu_data.dart';
import 'package:tryve/services/api/parse/user_api/user_api.dart';
import 'package:tryve/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final menus = ProfileMenu.menus;

  User _user;

  @override
  void initState() {
    super.initState();
    _user = context.read<AuthenticationService>().getUser();
  }

  Widget _options() {
    return Column(
      children: menus.map((menu) {
        final index = menus.indexOf(menu);
        return Column(
          children: <Widget>[
            ListTile(
              onTap: () async {
                if (index == 0) {
                  await pushWidgetAwait(
                          newPage: CustomizeProfileScreen(
                            user: _user,
                          ),
                          context: context)
                      .then((_) {
                    setState(() {});
                  });
                }
                if (index == 6) {
                  context.read<AuthenticationService>().signOut();
                }
              },
              leading: Icon(
                menu.icon,
                size: 32,
                color: index == 6 ? Colors.red : Colors.grey,
              ),
              title: Text(
                menu.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              subtitle: Row(
                children: <Widget>[
                  Container(
                    width: 8,
                    height: 1,
                    color: Colors.grey,
                    margin: const EdgeInsets.only(right: 6),
                  ),
                  Text(menu.desc),
                ],
              ),
            ),
            if (index != (menus.length - 1))
              Divider(
                indent: 16,
              ),
          ],
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SystemThemeWrapper(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CustomClipShape(
              childDivider: 1,
              child: _ProfileInfo(
                user: _user,
              ),
            ),
            _options(),
          ],
        ),
      )),
    );
  }
}

class _ProfileInfo extends StatelessWidget {
  final User user;
  const _ProfileInfo({Key key, @required this.user}) : super(key: key);

  Widget _image(ParseResponse response) {
    return GestureDetector(
        onTap: () {},
        child: CommonAvatar(
          url: UserAPI.social(user)
              ? response.result[0]['socialImage']
              : response.result[0]['image']['url'],
        ));
  }

  Widget _name(ParseResponse response) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Text(
        response.result[0]["displayName"] != null
            ? response.result[0]["displayName"]
            : "Your name",
        style: TextStyle(
            fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _desc(ParseResponse response) {
    return Text(
      response.result[0]["description"] != null
          ? response.result[0]["description"]
          : "Your description",
      style: TextStyle(
          fontSize: 18,
          color: Colors.white.withOpacity(0.7),
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserAPI.getUserbyMail(user.email),
      builder: (context, AsyncSnapshot<ParseResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.success) {
            return Column(
              children: <Widget>[
                _image(snapshot.data),
                _name(snapshot.data),
                _desc(snapshot.data),
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 100),
                  child: Text(
                    "Couldn't fetch data",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            );
          }
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 100),
                child: CommonLoader(
                  android: true,
                ),
              )
            ],
          );
        }
      },
    );
  }
}
