import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:tryve/components/common_leading.dart';
import 'package:tryve/helpers/nav_helper.dart';

import 'package:tryve/screens/verify/write_post_screen.dart';
import 'package:tryve/theme/palette.dart';

const double kPageHeight = 420;

final TextStyle centerTextBaseStyle =
    TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.7));

class VerifySubScreen extends StatefulWidget {
  static String routeName = "/verify_sub_screen";
  final String image;
  const VerifySubScreen({Key key, @required this.image}) : super(key: key);

  @override
  _VerifySubScreenState createState() => _VerifySubScreenState();
}

class _VerifySubScreenState extends State<VerifySubScreen> {
  PageController _controller = PageController();
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _index = _controller.page.floor();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _image() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, 10),
                blurRadius: 10)
          ],
          image: DecorationImage(
              image: NetworkImage(widget.image), fit: BoxFit.cover)),
    );
  }

  Widget _info() {
    final counterTextStyle = TextStyle(
        fontSize: 25, color: Colors.white, fontWeight: FontWeight.w600);

    final infoStyle = TextStyle(fontSize: 16, color: Colors.white);

    return Container(
      height: 80,
      width: (MediaQuery.of(context).size.width - 32),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.black.withOpacity(0.4),
            Colors.black.withOpacity(0.5),
            Colors.black.withOpacity(0.6),
            Colors.black.withOpacity(0.7),
            Colors.black.withOpacity(0.8)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 60,
            width: 60,
            child: Stack(
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _index.toString(),
                        style:
                            counterTextStyle.copyWith(color: Palette.primary),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "1",
                        style: counterTextStyle,
                      ),
                    ),
                  ],
                ),
                Positioned.fill(
                    child: Container(
                  child: Center(
                    child: Transform.rotate(
                      angle: 0.698132,
                      child: Container(
                        height: 50,
                        width: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ))
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Drink 6 glasses of water / day",
                style: infoStyle,
              ),
              Text(
                "Weekly daily drink rae 0 %",
                style: infoStyle,
              )
            ],
          ),
          Icon(
            PhosphorIcons.caret_right,
            size: 32,
            color: Colors.white,
          )
        ],
      ),
    );
  }

  Widget _cameraButton() {
    return Center(
      child: CircleAvatar(
        radius: 60,
        child: Icon(
          PhosphorIcons.camera,
          size: 60,
          color: Colors.white,
        ),
        backgroundColor: Palette.primary,
      ),
    );
  }

  Widget _stackView() {
    return GestureDetector(
      onTap: () =>
          pushPage(newPage: WritePostScreen.routeName, context: context),
      child: Stack(
        children: [
          _image(),
          Positioned(
            bottom: 0,
            left: 0,
            child: _info(),
          ),
          Positioned.fill(child: _cameraButton())
        ],
      ),
    );
  }

  Widget _stacked() {
    return SizedBox(
      height: kPageHeight,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: _stackView(),
      ),
    );
  }

  Widget _pageView() {
    return SizedBox(
      height: kPageHeight,
      child: PageView(
        controller: _controller,
        children: [
          _stacked(),
          _stacked(),
        ],
      ),
    );
  }

  Widget _text() {
    return Column(
      children: [
        Text(
          "This is an example to help you understand the challenge authentication method",
          style: centerTextBaseStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          "Try pressing the camera down below",
          style: centerTextBaseStyle.copyWith(color: Palette.primary),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CommonLeading(
          color: Colors.black,
        ),
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_text(), _pageView()],
        ),
      ),
    );
  }
}
