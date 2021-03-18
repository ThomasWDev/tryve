import 'package:flutter/material.dart';
import 'package:tryve/components/custom_clip_shape.dart';
import 'package:tryve/components/system_theme_wrapper.dart';
import 'package:tryve/screens/profile/profile_menu_data.dart';
import 'package:tryve/services/auth/auth_service.dart';
import 'package:tryve/theme/palette.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final menus = ProfileMenu.menus;

  Widget _options() {
    return Column(
      children: menus.map((menu) {
        final index = menus.indexOf(menu);
        return Column(
          children: <Widget>[
            ListTile(
              onTap: () {
                if (index == 5) {
                  context.read<AuthenticationService>().signOut();
                }
              },
              leading: Icon(
                menu.icon,
                size: 32,
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
    return SystemThemeWrapper(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CustomClipShape(
              childDivider: 1,
              child: _ProfileInfo(),
            ),
            _options(),
          ],
        ),
      )),
    );
  }
}

class _ProfileInfo extends StatelessWidget {
  const _ProfileInfo({Key key}) : super(key: key);

  Widget _image() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 5,
        ),
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        backgroundImage:
            NetworkImage("https://randomuser.me/api/portraits/men/32.jpg"),
        backgroundColor: Palette.primary,
        radius: 70,
      ),
    );
  }

  Widget _name() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Text(
        "John Doe",
        style: TextStyle(
            fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _desc() {
    return Text(
      "Instructor & Athlete",
      style: TextStyle(
          fontSize: 18,
          color: Colors.white.withOpacity(0.7),
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _image(),
        _name(),
        _desc(),
      ],
    );
  }
}
