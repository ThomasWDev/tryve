import 'package:flutter/material.dart';
import 'package:tryve/helpers/toast_helper.dart';
import 'package:tryve/services/api/parse/goal_api/goal_api.dart';

class GoalState extends ChangeNotifier {
  List<dynamic> goals = [];
  bool loading = true;

  void fetchGoals() async {
    try {
      goals = await GoalAPI.getUserGoals() as List<dynamic>;
      loading = false;
    } catch (e) {
      goals = [];
      loading = false;
      toast("Goals failed to load");
    }

    notifyListeners();
  }

  void addGoal(dynamic goal) {
    goals.add(goal);
    notifyListeners();
  }
}
