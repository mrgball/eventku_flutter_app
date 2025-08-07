import 'dart:convert';

import 'package:event_app/features/auth/data/model/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // SecureStorage instance (untuk token)
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // SharedPreferences instance (untuk user biasa, darkmode, dsb)
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Keys
  static const String keyAccessToken = 'access_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyIsDarkMode = 'is_dark_mode';

  // Key untuk user
  static const String keyUser = 'user';

  /// -------------------- SECURE STORAGE --------------------

  Future<void> saveAccessToken(String token) async {
    await _secureStorage.write(key: keyAccessToken, value: token);
  }

  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: keyAccessToken);
  }

  Future<void> saveRefreshToken(String token) async {
    await _secureStorage.write(key: keyRefreshToken, value: token);
  }

  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: keyRefreshToken);
  }

  Future<void> clearSecureStorage() async {
    await _secureStorage.deleteAll();
  }

  /// -------------------- SHARED PREFERENCES --------------------

  Future<void> saveDarkMode(bool isDarkMode) async {
    await _prefs?.setBool(keyIsDarkMode, isDarkMode);
  }

  // Simpan user ke SharedPreferences
  Future<void> saveUser(UserModel user) async {
    final jsonString = jsonEncode(user.toJson());

    await _prefs?.setString(keyUser, jsonString);
  }

  // Ambil user dari SharedPreferences
  Future<UserModel?> getUser() async {
    final jsonString = _prefs?.getString(keyUser);

    if (jsonString == null) return null;

    try {
      return UserModel.fromJson(jsonDecode(jsonString));
    } catch (e) {
      return null;
    }
  }

  // Hapus user dari SharedPreferences
  Future<void> removeUser() async {
    await _prefs?.remove(keyUser);
  }

  bool getDarkMode() {
    return _prefs?.getBool(keyIsDarkMode) ?? false;
  }

  Future<void> clearSharedPrefs() async {
    await _prefs?.clear();
  }
}
