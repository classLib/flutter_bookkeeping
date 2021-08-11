//导航工具类
import 'package:flutter/material.dart';
import '../page/Bookkeeping.dart';
import 'package:flutter_bookkeeping/page/Home.dart';
import 'package:flutter_bookkeeping/page/Recommend.dart';
import 'package:flutter_bookkeeping/page/Report.dart';
import 'package:flutter_bookkeeping/page/profilePages/0.profile_page.dart';
import 'package:flutter_bookkeeping/util/constant.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IndexState();
  }
}

class _IndexState extends State<IndexPage> {
  // 底部菜单栏图表
  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "首页",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.analytics),
      label: "报表",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.create),
      label: "记账",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.recommend),
      label: "推荐",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "个人中心",
    ),
  ];

  // 维护当前下标状态
  int currentIndex;

  // 页面配置
  final pages = [
    HomePage(),
    ReportPage(),
    BookkeepingPage(),
    RecommendPage(),
    ProfilePage()
  ];

  // 初始化状态
  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Book"),
        backgroundColor: themeColorMap[Constant.key_theme_color],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).accentColor,
        onTap: (index) {
          _changePage(index);
        },
      ),
      body: pages[currentIndex],
    );
  }

  // 切换页面
  void _changePage(int index) {

    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }
}
