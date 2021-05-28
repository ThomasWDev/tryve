import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class RoundedInput extends StatelessWidget {
  final Color backgroundColor;
  final TextEditingController controller;
  final IconData icon;
  final int lines;
  final String hint;

  const RoundedInput(
      {Key key,
      this.backgroundColor = Colors.white,
      this.controller,
      this.icon = PhosphorIcons.tag,
      this.lines = 1,
      this.hint = "Add title"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Icon(icon, size: 20),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: TextField(
              maxLines: lines,
              controller: controller ?? TextEditingController(),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                  hintStyle: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
