import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/api_endpoint.dart';

class LocalStorageServices {
  final SharedPreferences sharedPreferences;

  LocalStorageServices({required this.sharedPreferences});

  Future<void> saveUserToken(String token) async {
    try {
      await sharedPreferences.setString(ApiUrls.userToken, token);
      if (kDebugMode) {
        debugPrint("========>User Token Stored<=======");
        debugPrint(sharedPreferences.getString(ApiUrls.userToken));
      }
    } catch (e) {
      rethrow;
    }
  }

  getUserToken() {
    SharedPreferences.getInstance();
    return sharedPreferences.getString(ApiUrls.userToken) ?? "";
  }

  Future<bool> removeUserToken() async {
    await SharedPreferences.getInstance();
    return sharedPreferences.remove(ApiUrls.userToken);
  }

  Future<void> saveRefreshToken(String token) async {
    try {
      await sharedPreferences.setString(ApiUrls.refreshToken, token);
      if (kDebugMode) {
        debugPrint("========>Refresh Token Stored<=======");
        debugPrint(sharedPreferences.getString(ApiUrls.refreshToken));
      }
    } catch (e) {
      rethrow;
    }
  }

  getRefreshToken() {
    SharedPreferences.getInstance();
    return sharedPreferences.getString(ApiUrls.refreshToken) ?? "";
  }

  Future<bool> removeRefreshToken() async {
    await SharedPreferences.getInstance();
    return sharedPreferences.remove(ApiUrls.refreshToken);
  }


  Future<void> saveLocalData({
    required String key,
    required String value,
  }) async {
    try {
      await sharedPreferences.setString(key, value);
      if (kDebugMode) {
        debugPrint("========>Save in local data<=======");
        final data = await sharedPreferences.getString(key);
        debugPrint(data);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getLocalData({required String key}) async {
    try {
      final data = await sharedPreferences.getString(key);
      if (kDebugMode) {
        debugPrint("========>Get from local data<=======");
        debugPrint(data);
      }
      return data ?? "";
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveLocalListDate({
    required String key,
    required List<String> value,
  }) async {
    try {
      await sharedPreferences.setStringList(key, value);
      if (kDebugMode) {
        debugPrint("========>Save in local data<=======");
        final data = sharedPreferences.getStringList(key);
        debugPrint(data.toString());
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<String>> getLocalListDate({required String key}) async {
    try {
      final data = sharedPreferences.getStringList(key);
      if (kDebugMode) {
        debugPrint("========>Get from local data<=======");
        debugPrint(data.toString());
      }
      return data ?? [];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveSelectedLanguage(String locale) async {
    await sharedPreferences.setString(ApiUrls.selectedLanguage, locale);
  }

  String getSelectedLanguage() {
    return sharedPreferences.getString(ApiUrls.selectedLanguage) ?? "";
  }
}
