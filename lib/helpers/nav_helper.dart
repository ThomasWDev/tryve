import 'package:flutter/material.dart';

/// Push a new page , uses Navigator.push method [FOR DRAWER ONLY]
void pushPageForDrawer({
  @required String newPage,
  @required BuildContext context,
}) {
  Navigator.of(context).pop();
  Navigator.of(context).pushNamed(newPage);
}

/// Push a new page , uses Navigator.push method
void pushPage(
    {@required String newPage,
    @required BuildContext context,
    bool pushBackPrevPage = false}) {
  if (pushBackPrevPage) {
    Navigator.of(context).pop();
  }
  Navigator.of(context).pushNamed(newPage);
}

void pushPageWidget(
    {@required Widget newPage,
    @required BuildContext context,
    bool pushBackPrevPage = false}) {
  if (pushBackPrevPage) {
    Navigator.of(context).pop();
  }
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => newPage));
}

void pushPageWhileRemove(
    {@required String newPage,
    @required BuildContext context,
    bool pushBackPrevPage = false}) {
  if (pushBackPrevPage) {
    Navigator.of(context).pop();
  }
  Navigator.of(context).pushNamedAndRemoveUntil(newPage, (route) => false);
}

Future<dynamic> pushPageAwait(
    {@required String newPage,
    @required BuildContext context,
    bool pushBackPrevPage = false}) async {
  if (pushBackPrevPage) {
    Navigator.of(context).pop();
  }
  return Future.value(await Navigator.of(context).pushNamed(newPage));
}

/// Replcae with a new page , uses Navigator.pushReplacement method
void replacePage({@required String newPage, @required BuildContext context}) {
  Navigator.of(context).pushReplacementNamed(newPage);
}
