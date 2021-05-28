import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:tryve/helpers/toast_helper.dart';
import 'package:tryve/services/api/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:tryve/state/goals_state.dart';

const _kObjName = "Person";
final _user = ParseObject(_kObjName);

class UserAPI {
  static Future<ParseResponse> getUser(String id) {
    return _user.getObject(id);
  }

  static Future<ParseResponse> createUser(UserModel user) {
    _user.set("email", user.email);
    _user.set("displayName", user.displayName);
    _user.set("social", user.social);

    if (user.description != null && user.description.isNotEmpty) {
      _user.set("description", user.description);
    }

    if (user.social) {
      _user.set("socialImage", user.socialImage);
    } else {
      if (user.image != null) {
        _user.set("image", user.image);
      }
    }

    return _user.save();
  }

  static Future<bool> accountExists(String email) async {
    final query = QueryBuilder<ParseObject>(_user)
      ..whereEqualTo('email', email);
    final response = await query.query();

    if (response.success) {
      if (response.result != null) {
        return true;
      } else {
        return false;
      }
    } else {
      return null;
    }
  }

  static Future<ParseResponse> getUserbyMail([String email]) async {
    final query = QueryBuilder<ParseObject>(_user)
      ..whereEqualTo('email', email ?? FirebaseAuth.instance.currentUser.email);
    final response = await query.query();

    if (response.success) {
      return response;
    } else {
      return null;
    }
  }

  static bool social(User user) {
    return !(user.providerData[0].providerId == 'password');
  }

  static Future<ParseResponse> addGoal(
      String id, dynamic data, BuildContext context) async {
    if ((context
            .read<GoalState>()
            .goals
            .indexWhere((element) => element == id)) !=
        -1) {
      toast("You already took this goal");

      return null;
    } else {
      toast("Goal added");
      FirebaseAuth _auth = FirebaseAuth.instance;
      final _response = await UserAPI.getUserbyMail(_auth.currentUser.email);
      final _user = ParseObject(_kObjName)
        ..objectId = _response.result[0]['objectId']
        ..setAdd('goals', id);
      context.read<GoalState>().addGoal(id);

      final _goal = ParseObject("Goal")
        ..objectId = id
        ..set("peopleJoined", data['peopleJoined'] + 1);

      await _goal.save();

      return _user.save();
    }
  }

  static Future<ParseResponse> addPost({
    @required String userId,
    @required String postId,
  }) {
    final user = ParseObject(_kObjName)
      ..objectId = userId
      ..setAdd('feedPosts', postId);
    return user.save();
  }
}
