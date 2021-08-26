import 'package:flutter/material.dart';
import 'bookKeeping/keeping_expenditure.dart';
import 'bookKeeping/keeping_income.dart';
/*
* 记账页面（已完成）
* 1. 分类和支出单独分开
* 2. 分类展示，图片配文字进行展示，点击可以进行选择上，颜色改变
* 3. 钱数输入框，可以根据我选择的进行相应
* 4. 时间输入框，做时间选择器，可以选择出时间，确定好格式
* 5. 备注输入框，支持语音输入，文字输入
* 6. 算数按键板，可根据点击了记账位置，弹出，也可以直接做好
*
* 待完成：
* 1. 类别新增之后，直接可以看到结果
* 2. 数据持久化，新增过来的不能时刻保持在本地存储里面
* 3. 输入的钱数计算结果返回到controller中
* 4. 日期选择框优化
* 5. 支出部分完善，包括收入的分类页面和分类管理
* 6. 数据库两张表的查询完善，包括按照年份查询，按照belong查询，
*
*
* */

class BookkeepingPage extends StatefulWidget {
  const BookkeepingPage({Key key}) : super(key: key);

  @override
  _BookkeepingPageState createState() => _BookkeepingPageState();
}

class _BookkeepingPageState extends State<BookkeepingPage> {
  final List<Tab> myTabs = <Tab>[
    Tab(text: '支出'),
    Tab(text: '收入'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("记一笔", textAlign: TextAlign.center),
          bottom: TabBar(tabs: myTabs),
          backgroundColor: Theme.of(context).primaryColor,
          automaticallyImplyLeading: false,
        ),
        body: TabBarView(children: <Widget>[
          KeepExpenditure(),
          KeepIncome(),
        ]),
      ),
    );
  }
}
