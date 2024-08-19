import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  static const _isFirstKey = 'isFirst';
  static const _userIdKey = 'userId';

  SharedPreferences get _prefs => GetIt.instance<SharedPreferences>();

  Future<void> setIsFirst(bool isFirst) async {
    await _prefs.setBool(_isFirstKey, isFirst);
  }

  Future<bool> getIsFirst() async {
    return _prefs.getBool(_isFirstKey) ?? true;
  }

  Future<void> setUserId(String userId) async {
    await _prefs.setString(_userIdKey, userId);
  }

  Future<String?> getUserId() async {
    return _prefs.getString(_userIdKey);
  }
}
