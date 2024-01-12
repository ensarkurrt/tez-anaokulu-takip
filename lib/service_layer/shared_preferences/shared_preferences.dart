import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  static SharedPreferencesService get instance {
    if (_instance != null) return _instance!;
    _instance = SharedPreferencesService._init();
    return _instance!;
  }

  SharedPreferencesService._init();

  Future<int?> getInt({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getInt(key);
    return value;
  }

  Future<bool> setInt({required String key, required int value}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }

  Future<double?> getDouble({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getDouble(key);
    return value;
  }

  Future<bool> setDouble({required String key, required int value}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }

  Future<String?> getString({required String key, String? defaultValue}) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key);
    return value ?? defaultValue;
  }

  Future<bool> setString({required String key, required String value}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  Future<bool> remove({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  Future<bool?> getBool({required String key, bool? defaultValue}) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool(key);
    return value ?? defaultValue;
  }

  Future<bool> setBool({required String key, required bool value}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }
}
