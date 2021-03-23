import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:tryve/components/common_leading.dart';
import 'package:tryve/components/gradient_text.dart';
import 'package:tryve/helpers/nav_helper.dart';
import 'package:tryve/screens/verify/complete_verification_screen.dart';
import 'package:tryve/theme/palette.dart';

class WritePostScreen extends StatefulWidget {
  static String routeName = "/write_post_screen";
  WritePostScreen({Key key}) : super(key: key);

  @override
  _WritePostScreenState createState() => _WritePostScreenState();
}

class _WritePostScreenState extends State<WritePostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyTextCotroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8.0,
        leading: CommonLeading(
          color: Colors.white,
        ),
        title: Text("Write a post"),
        brightness: Brightness.dark,
        actions: [
          IconButton(
              tooltip: "Add location",
              onPressed: () {},
              icon: Icon(PhosphorIcons.map_pin)),
          IconButton(
              tooltip: "Tag people",
              onPressed: () {},
              icon: Icon(PhosphorIcons.tag)),
          IconButton(
              tooltip: "Clear text",
              onPressed: () => _bodyTextCotroller.clear(),
              icon: Icon(PhosphorIcons.trash)),
        ],
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
            child: TextField(
              controller: _titleController,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter title here",
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 22,
                  )),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _bodyTextCotroller,
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
          maxLines: 1000,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Your post content",
              hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontSize: 22,
              )),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0.0, -4.0),
                  blurRadius: 30),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextButton(
                    child: Row(
                      children: [
                        GradientText(
                            colors: [Palette.primary, Palette.mango],
                            text: "Post",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                        const SizedBox(
                          width: 4,
                        ),
                        Icon(
                          PhosphorIcons.caret_right,
                          color: Palette.mango,
                          size: 20,
                        )
                      ],
                    ),
                    onPressed: () => pushPage(
                        newPage: CompleteVerificationScreen.routeName,
                        context: context)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
