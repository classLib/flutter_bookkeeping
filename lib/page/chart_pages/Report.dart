import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/dao/keepDbHelper.dart';
import 'package:flutter_bookkeeping/model/keepSetting/keep_record.dart';
import 'package:flutter_bookkeeping/page/bookKeeping/categorySettingTest.dart';
import 'package:flutter_bookkeeping/page/chart_pages/month_chart_page.dart';
import 'package:flutter_bookkeeping/page/chart_pages/year_chart_page.dart';
import 'package:flutter_bookkeeping/util/DbHelper.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  //数据库
  DbHelper provider = DbHelper.instance;
  final List<Tab> myTabs = <Tab>[
    Tab(text: '月份'),
    Tab(text: '年度')
  ];


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("记账分析"),
          bottom: TabBar(tabs: myTabs),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: TabBarView(children: <Widget>[
          MonthChartPage(),
          YearChartPage()
        ]),
      ),
    );
  }
}
