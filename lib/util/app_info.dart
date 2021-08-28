/// FileName: app_info
/// Author: hjy
/// Date: 2021/8/9 21:11
/// Description:使用Provider全局状态管理

import 'package:flutter/material.dart';
//通过with关键字生成一个ChangeNotifier的混合类。
// 该类用来为counter类创建侦听，并通过在Increment和decrement方法里notifyListeners();方法被调用。
//可以通过Counter类的实例化来调用其中的方法，
// 在代码中的HomePage组件中使用Counter类方法是：
// material app中homepage组件外使用ChangeNotifierProvider进行封装。
class AppInfoProvider with ChangeNotifier {
  String _themeColor = '';

  String get themeColor => _themeColor;

  void setTheme(String themeColor) {
    _themeColor = themeColor;
    // 数据改变时，使用notifyListeners通知组件更新
    notifyListeners();
  }
}
