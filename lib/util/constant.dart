/// FileName: constant
/// Author: hjy
/// Date: 2021/8/9 21:13
/// Description:

import 'package:flutter/material.dart';

class Constant {
  static String username = "admin";
  static String password = "123456";
  static String headPhoto = "head_photo";
  static String keyThemeColor = 'key_theme_color';
  // static const String key_guide = 'key_guide';
  // static const String key_splash_model = 'key_splash_models';
  // static const String key_current_source = 'key_current_source';
  // static const String key_db_name = 'player.db';
}

//年度列表
Map<int, String> yearMap = {
  2018: "2018年",
  2019: "2019年",
  2020: "2020年",
  2021: "2021年"
};
//月份列表
Map<int, String> monthMap = {
  1: "1月",
  2: "2月",
  3: "3月",
  4: "4月",
  5: "5月",
  6: "6月",
  7: "7月",
  8: "8月",
  9: "9月",
  10: "10月",
  11: "11月",
  12: "12月"
};
//主题样式列表
Map<String, Color> themeColorMap = {
  'gray': Colors.grey,
  'blue': Colors.blue,
  'blueAccent': Colors.blueAccent,
  'cyan': Colors.cyan,
  'deepPurple': Colors.purple,
  'deepPurpleAccent': Colors.deepPurpleAccent,
  'deepOrange': Colors.orange,
  'green': Colors.green,
  'indigo': Colors.indigo,
  'indigoAccent': Colors.indigoAccent,
  'orange': Colors.orange,
  'purple': Colors.purple,
  'pink': Colors.pink,
  'red': Colors.red,
  'teal': Colors.teal,
  'black': Colors.black,
};
