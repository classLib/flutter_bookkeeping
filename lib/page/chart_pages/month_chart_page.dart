import 'dart:convert';
import "package:collection/collection.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/dao/keepDbHelper.dart';
import 'package:flutter_bookkeeping/model/keepSetting/keep_record.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';

/// FileName: month_chart_page
/// Author: hjy
/// Date: 2021/8/12 19:33
/// Description:月份报表

/// 页面：
///  月份筛选
///  饼图
///  可行性日历
///  消费list

class MonthChartPage extends StatefulWidget {
  const MonthChartPage({Key key}) : super(key: key);

  @override
  _MonthChartPageState createState() => _MonthChartPageState();
}

class _MonthChartPageState extends State<MonthChartPage> {
  //找表，查找所有
  Future<List<KeepRecord>> keepRecords = KeepDbHelper.queryAll();
  List<KeepRecord> keepHistory = [];

  var _monthKey = "2021年8月";
  //日历图范围
  var range = ['2017-01'];
  //该月list，月支出，月收入
  List monthList = [], monthPay = [], monthIncome = [];
  //饼图数据
  var data = [
    {"value": 335, "name": '餐饮'},
    {"value": 310, "name": '交通'},
    {"value": 234, "name": '出行'},
    {"value": 123, "name": "出行"}
  ];
  //饼图图例
  var legendData = ['餐饮', '交通', '出行', '11'];

  //日历图数据
  var dateList = [
    ['2017-1-1', '100'],
    ['2017-1-2', '10'],
    ['2017-1-3', '1'],
    ['2017-1-4', '22'],
    ['2017-1-5', '25'],
    ['2017-1-6', '98'],
    ['2017-1-7', '25'],
    ['2017-1-8', '66'],
    ['2017-1-9', '88'],
    ['2017-1-10', '66'],
    ['2017-1-11', '33'],
    ['2017-1-12', '22'],
    ['2017-1-13', '47'],
    ['2017-1-14', '36'],
    ['2017-1-15', '100'],
    ['2017-1-16', '600'],
    ['2017-1-17', '300.3'],
    ['2017-1-18', '60'],
    ['2017-1-19', '70'],
    ['2017-1-20', '99.0'],
    ['2017-1-21', '100.0'],
    ['2017-1-22', '210'],
    ['2017-1-23', '265'],
    ['2017-1-24', '444'],
    ['2017-1-25', '44'],
    ['2017-1-26', '22'],
    ['2017-1-27', '333'],
    ['2017-1-28', '324'],
    ['2017-1-29', '234'],
    ['2017-1-30', '324'],
    ['2017-1-31', '768']
  ];
  int choice = 1;
  var heatmapData = [];
  var lunarData = [];

  @override
  void initState() {
    super.initState();
    //查询所有
    Future<List<KeepRecord>> keepRecords = KeepDbHelper.queryAll();
    keepRecords.then((value) {
      setState(() {
        this.keepHistory = value;
      });
    });
  }

  //图标
  List menuIcons = [
    Icons.message,
    Icons.print,
    Icons.error,
    Icons.phone,
    Icons.send,
    Icons.people,
    Icons.person,
    Icons.phone,
  ];

  getCalenderDate(List dateList, List heatmapData, List lunarData) {
    for (var i = 0; i < dateList.length; i++) {
      heatmapData.add([dateList[i][0], dateList[i][1]]);
      lunarData
          .add([dateList[i][0].toString(), 1, dateList[i][1].toString(), 0]);
    }
  }

  //点击radio按钮选择
  _onRadioChanged(value) {
    setState(() {
      this.choice = value;
    });
    // 根据获取的值来筛选支出和收入
    if (this.choice == 1) {
      //  筛选月支出消费
      setState(() {
        //图例
        this.legendData = List<String>.from(monthPay.asMap().keys.map((i) => monthPay[i].recordCategoryName));

      });
    } else {
      //  筛选月收入消费
    }
  }

  //饼图
  Widget pie() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: 60,
            ),
            Text("月支出"),
            Radio(
              value: 1,
              onChanged: (value) {
                _onRadioChanged(value);
              },
              // 按钮组的值
              groupValue: this.choice,
            ),
            // add(),
            SizedBox(
              width: 20,
            ),
            Text("月收入"),
            Radio(
              value: 2,
              onChanged: (value) {
                _onRadioChanged(value);
              },
              groupValue: this.choice,
            ),
          ],
        ),
        Container(
          width: 300,
          height: 250,
          child: Echarts(
            option: '''{
        legend: {
        orient: 'vertical',
        left: 10,
        data: ${jsonEncode(legendData)}
    },
    tooltip: {
        // trigger: 'item',
        formatter: '{b}<br/>{c} ({d}%)'
    },
    series: [
        {
            name: '访问来源',
            type: 'pie',
            radius: ['50%', '70%'],
            avoidLabelOverlap: false,
            label: {
                // show: false,
                position: 'inside'
            },
            emphasis: {
                label: {
                    show: true,
                    fontSize: '15',
                    fontWeight: 'bold'
                }
            },
            data: ${jsonEncode(data)}
        }
    ]
}''',
          ),
        )
      ],
    );
  }

  //可行性日历
  Widget calendar() {
    getCalenderDate(dateList, heatmapData, lunarData);
    return Column(
      children: <Widget>[
        Row(),
        Container(
          width: 300,
          height: 250,
          child: Echarts(
            option: '''
            {
    visualMap: {
        show: false,
        min: 0,
        max: 700
    },
    calendar: {
        range: ${jsonEncode(range)},
        orient: 'vertical',
    },
    series: {
        type: 'heatmap',
        coordinateSystem: 'calendar',
        data: ${jsonEncode(dateList)}
    }
}''',
          ),
        )
      ],
    );
  }

  //分出月收入和月支出的
  handleMonth() {
    for (var item in monthList) {
      if (item.recordCategoryNum == 1) {
        monthPay.add(item);
      } else {
        monthIncome.add(item);
      }
    }
  }

  //点击选中时间
  _onTimeSelect(model) {
    Pickers.showDatePicker(context, mode: model, onConfirm: (p) {
      setState(() {
        _monthKey = '${p.year}年${p.month}月';
        range = ['${p.year}-${p.month}'];
        //this.keepHistory中找到这一年这一月
        monthList.clear();
        for (var each in this.keepHistory) {
          var year = each.recordTime.substring(0, 4);
          var month = each.recordTime.substring(5, 7);
          if (year == p.year.toString() && int.parse(month) == p.month) {
            monthList.add(each);
          }
        }
        handleMonth();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.separated(
        itemCount: data.length + 4,
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return ListTile(
              onTap: () {
                _onTimeSelect(DateMode.YM);
              },
              title: Text("选择月份"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(_monthKey),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
            );
          } else if (index == 1) {
            return pie();
          } else if (index == 2) {
            return calendar();
          } else if (index == data.length + 3) {
            return Container(
                color: Theme.of(context).accentColor,
                margin: EdgeInsets.only(top: 20, left: 25, right: 25),
                width: MediaQuery.of(context).size.width,
                height: 45,
                // ignore: deprecated_member_use
                child: new MaterialButton(
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white,
                  child: new Text('导出消费记录'),
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                ));
          } else {
            return ListTile(
              leading: Icon(menuIcons[index - 3]), //左边
              title: Text(data[index - 3]["name"]), //title
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${data[index - 3]["value"]}元'),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

