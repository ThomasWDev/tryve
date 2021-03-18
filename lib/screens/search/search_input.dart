import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        children: <Widget>[
          Icon(PhosphorIcons.magnifying_glass, size: 20),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "What do want to invest",
                  hintStyle: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
