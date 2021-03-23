import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:tryve/components/animated_fab.dart';
import 'package:tryve/components/common_leading.dart';
import 'package:tryve/components/gradient_text.dart';
import 'package:tryve/services/api/mock.dart';
import 'package:tryve/theme/palette.dart';

class MessageScreen extends StatefulWidget {
  static String routeName = "/message_screeen";
  MessageScreen({Key key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen>
    with SingleTickerProviderStateMixin {
  final List<ChatMessage> chatMessages = ChatMessages().messages();

  ScrollController _scrollController = ScrollController();
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 200,
        ),
        value: 1.0);

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        _animationController.reverse();
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _scrollController?.dispose();
    super.dispose();
  }

  String _formatDate(DateTime time) {
    return "${time.hour}:${time.minute} PM";
  }

  Widget _renderChat(ChatMessage message) {
    return ListTile(
      onTap: () {},
      contentPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      title: Text(
        message.userName,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: -1.2,
            color: Palette.darkTextShade1),
      ),
      leading: _avatar(message, isActive: !message.isPremium),
      subtitle: Text(
        message.message,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          message.isPremium ? const SizedBox.shrink() : Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              _formatDate(message.date),
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          message.isPremium
              ? Container(
                  margin: const EdgeInsets.only(top: 6.0, right: 8.0),
                  decoration: BoxDecoration(
                      color: Palette.mango,
                      borderRadius: BorderRadius.circular(100.0)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: Text(
                    "Premium",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                )
              : Spacer()
        ],
      ),
    );
  }

  Widget _avatar(
    ChatMessage message, {
    bool isActive = true,
  }) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(message.url),
          radius: 40,
          backgroundColor: Palette.primary,
        ),
        isActive
            ? Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.green,
                  ),
                ))
            : const SizedBox.shrink()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.white,
        title: GradientText(
          colors: [Palette.primary, Palette.mango],
          text: "Message",
          style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: -2,
              color: Colors.white),
        ),
        centerTitle: false,
        leading: CommonLeading(
          color: Colors.black,
        ),
        actions: [
          IconButton(
            icon: Icon(
              PhosphorIcons.magnifying_glass,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        color: Palette.primary,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ListView.separated(
            controller: _scrollController,
            itemBuilder: (context, index) {
              final ChatMessage message = chatMessages[index];
              return _renderChat(message);
            },
            itemCount: chatMessages.length,
            separatorBuilder: (context, index) => Divider(
              indent: 16,
            ),
          ),
        ),
      ),
      floatingActionButton: AnimatedFAB(
        controller: _animationController,
        onPressed: () {},
        backgroundColor: Palette.mango,
        icon: Icon(
          PhosphorIcons.plus,
          // size: 2,
        ),
      ),
    );
  }
}
