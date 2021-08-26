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

  static const String email_code = 'lkcxmzwofllbdidf';

  static const String key_account = "user_account";
  static const String key_password = "user_password";
  static const String is_login = "is_login";
  // static const String key_guide = 'key_guide';
  // static const String key_splash_model = 'key_splash_models';
  // static const String key_current_source = 'key_current_source';
  // static const String key_db_name = 'player.db';
}
//收入支出记录表

class KeepTable {
  //表名
  // ignore: non_constant_identifier_names
  static final String TABLE_NAME = "keep_record_table";
  //  记录的id
  static final String recordId = "id";
//  图片编号
  static final String recordImage = "image_num";
//分类名称
  static final String recordCategoryName = "record_category_name";
//记录的备注
  static final String recordRemarks = "record_remarks";
//记录的钱数
  static final String recordNumber = "record_number";
//记录类型
  static final String recordCategoryNum = "record_category_num";
//记录时间
  static final String recordTime = "record_time";
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
