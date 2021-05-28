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

void pushWidget(
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

void pushWidgetWhileRemove(
    {@required Widget newPage,
    @required BuildContext context,
    bool pushBackPrevPage = false}) {
  if (pushBackPrevPage) {
    Navigator.of(context).pop();
  }
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => newPage), (route) => false);
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

Future<dynamic> pushWidgetAwait(
    {@required Widget newPage,
    @required BuildContext context,
    bool pushBackPrevPage = false}) async {
  if (pushBackPrevPage) {
    Navigator.of(context).pop();
  }
  return Future.value(await Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => newPage)));
}

/// Replcae with a new page , uses Navigator.pushReplacement method
void replacePage({@required String newPage, @required BuildContext context}) {
  Navigator.of(context).pushReplacementNamed(newPage);
}

void replaceWidget({@required Widget newPage, @required BuildContext context}) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => newPage));
}

void pop(BuildContext context) {
  Navigator.of(context).pop();
}
