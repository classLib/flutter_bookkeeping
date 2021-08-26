import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/page/loginPages/login_page.dart';
import 'package:flutter_bookkeeping/util/app_info.dart';
import 'package:flutter_bookkeeping/page/profilePages/0.profile_page.dart';
import 'package:flutter_bookkeeping/util/constant.dart';
import 'package:flutter_bookkeeping/util/navigator_util.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color _themeColor;
    // 设置全局数据的主题样式
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AppInfoProvider())],
      child: Consumer<AppInfoProvider>(
        builder: (context, appInfo, _) {
          String colorKey = appInfo.themeColor;
          if (themeColorMap[colorKey] != null) {
            _themeColor = themeColorMap[colorKey];
          }

          return MaterialApp(
            theme: ThemeData.light().copyWith(
                primaryColor: _themeColor,
                accentColor: _themeColor,
                indicatorColor: Colors.white),
            home: LoginPage(),
          );
        },
      ),
    );
  }
}
