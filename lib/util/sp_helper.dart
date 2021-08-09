/// FileName: sp_helper
/// Author: hjy
/// Date: 2021/8/9 21:10
/// Description: shared_preferences持久化

import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

class SpHelper {
  static SpHelper _intance;
  static SharedPreferences _prefs;
  static Lock _lock = Lock();

  static Future<SpHelper> getInstance() async {
    if (_intance == null) {
      await _lock.synchronized(() async {
        if (_intance == null) {
          // keep local instance till it is fully initialized.
          // 保持本地实例直到完全初始化。
          var instance = SpHelper._();
          await instance._init();
          _intance = instance;
        }
      });
    }
    return _intance;
  }

  // 私有构造函数
  SpHelper._();

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// get string.
  static String getString(String key, {String defValue = ''}) {
    if (_prefs == null) return defValue;
    return _prefs.getString(key) ?? defValue;
  }

  /// put string.
  static Future<bool> putString(String key, String value) {
    if (_prefs == null) return null;
    return _prefs.setString(key, value);
  }

  /// have key.
  static bool haveKey(String key) {
    if (_prefs == null) return null;
    return _prefs.getKeys().contains(key);
  }

  /// get keys.
  static Set<String> getKeys() {
    if (_prefs == null) return null;
    return _prefs.getKeys();
  }

  /// remove.
  static Future<bool> remove(String key) {
    if (_prefs == null) return null;
    return _prefs.remove(key);
  }

  /// clear.
  static Future<bool> clear() {
    if (_prefs == null) return null;
    return _prefs.clear();
  }

  ///Sp is initialized.
  static bool isInitialized() {
    return _prefs != null;
  }
}
