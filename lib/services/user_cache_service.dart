import 'dart:convert';
import 'package:flutter_project/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userCacheProvider = Provider((ref) => UserCacheService());

const String _CACHE_KEY = 'usercach';

class UserCacheService {
  User? _user;
  User? get user => _user;

  UserCacheService() {
    _getUser();
  }
  Future<bool> saveUser(User user) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    var map = user.toMap();
    bool saved = await sharedPrefs.setString(_CACHE_KEY, jsonEncode(map));
    if (saved) {
      _user = await _getUser();
    }
    return saved;
  }

  Future<User?> _getUser() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    User usr;
    var userMap = sharedPrefs.getString(_CACHE_KEY);
    if (userMap == null) {
      return null;
    }
    usr = User.fromMap(jsonDecode(userMap));
    _user = usr;
    return usr;
  }

  Future<bool> deleteUser() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    _user = null;
    return await sharedPrefs.remove(_CACHE_KEY);
  }
}
//double confirmation on start and end ride