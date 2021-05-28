import 'package:flutter/material.dart';
import 'package:tryve/helpers/toast_helper.dart';
import 'package:tryve/services/api/parse/feed_api/feed_api.dart';

class FeedState extends ChangeNotifier {
  List<dynamic> feeds = [];
  bool loading = true;

  void fetchGoals() async {
    try {
      feeds = await FeedAPI.getUserFeeds() as List<dynamic>;
      loading = false;
    } catch (e) {
      feeds = [];
      loading = false;
      toast("Feeds failed to load");
    }

    notifyListeners();
  }

  void addPost(dynamic post) {
    feeds.add(post);
    notifyListeners();
  }
}
