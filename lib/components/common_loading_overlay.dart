import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tryve/theme/palette.dart';

class CommonLoadingOverlay extends StatelessWidget {
  final bool loading;
  final Widget child;
  const CommonLoadingOverlay(
      {Key key, @required this.child, @required this.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: loading,
      color: Colors.black.withOpacity(0.5),
      child: child,
      progressIndicator: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Palette.primary),
      ),
    );
  }
}
