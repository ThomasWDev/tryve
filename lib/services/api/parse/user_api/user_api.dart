import 'package:firebase_auth/firebase_auth.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:tryve/services/api/models/user_model.dart';

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

  static Future<ParseResponse> getUserbyMail(String email) async {
    final query = QueryBuilder<ParseObject>(_user)
      ..whereEqualTo('email', email);
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
}
