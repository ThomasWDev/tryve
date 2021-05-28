import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

const _kObjName = "FeedPost";
final _feed = ParseObject(_kObjName);

class FeedAPI {
  static Future<dynamic> getUserFeeds() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final query = QueryBuilder<ParseObject>(_feed)
      ..whereNotEqualTo('by', _auth.currentUser.uid);
    final response = await query.query();

    if (response.success) {
      final data = response.result;
      if (data == null) {
        return [];
      } else {
        return data;
      }
    } else {
      return [];
    }
  }

  static Future<ParseResponse> createPost({
    @required String title,
    @required String description,
    @required List<String> tags,
    @required List<File> files,
  }) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _feed.set("title", title);
    _feed.set("description", description);
    _feed.set("tags", tags);

    final parseFiles = files.map((file) => ParseFile(file)).toList();
    _feed.set("images", parseFiles);
    _feed.set("by", _auth.currentUser.uid);

    return _feed.save();
  }
}
