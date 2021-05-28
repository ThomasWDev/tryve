import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:tryve/components/common_chat_avatar.dart';
import 'package:tryve/components/common_leading.dart';

class ChatScreen extends StatefulWidget {
  static String routeName = "/chat";
  ChatScreen({Key key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonChatAvar(
              url: faker.image.image(),
              isActive: true,
              radius: 20,
              activeRadius: 5,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              "Thomas Woodfin",
              style: TextStyle(
                color: Colors.black,
              ),
            )
          ],
        ),
        centerTitle: false,
        leading: CommonLeading(
          color: Colors.black,
        ),
        actions: [
          IconButton(
            icon: Icon(PhosphorIcons.dots_three_vertical, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: Center(
        child: Text("Chat screen"),
      ),
    );
  }
}
