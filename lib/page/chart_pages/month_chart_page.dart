import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/page/chart_pages/filter_widget.dart';
import 'package:flutter_bookkeeping/util/constant.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';

/// FileName: month_chart_page
/// Author: hjy
/// Date: 2021/8/12 19:33
/// Description:月份报表

class MonthChartPage extends StatefulWidget {
  const MonthChartPage({Key key}) : super(key: key);

  @override
  _MonthChartPageState createState() => _MonthChartPageState();
}

class _MonthChartPageState extends State<MonthChartPage> {
  var data = [
    {"value": 335, "name": '餐饮'},
    {"value": 310, "name": '交通'},
    {"value": 234, "name": '出行'},
  ];
  var legendData = [
    '餐饮',
    '交通',
    '出行',
  ];

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
  var _monthKey;
  int choice = 1;

  //点击时间选择器事件
  _onTimeSelector(key) {
    setState(() {
      _monthKey = key;
    });
    //向数据库请求当前_monthKey的消费状况
    print(key);
  }

  //点击radio按钮选择
  _onRadioChanged(value) {
    setState(() {
      this.choice = value;
    });
    // 根据获取的值来筛选支出和收入
    if (value == 1) {
      //  筛选月支出消费
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
        trigger: 'item',
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
                    fontSize: '30',
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

  Widget list() {
    return Expanded(
        child: ListView.separated(
            itemCount: data.length,
            separatorBuilder: (context, index) {
              return Divider();
            }, //分隔线
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: menuIcons[index],
                title: Text("111"),
              );
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.separated(
        itemCount: data.length + 2,
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return ExpansionTile(
              leading: Icon(Icons.date_range),
              title: Text("月份筛选"),
              initiallyExpanded: true,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Wrap(
                    spacing: 8,
                    // runSpacing: 8,
                    children: monthMap.keys.map((key) {
                      var value = monthMap[key];
                      return InkWell(
                        onTap: () {
                          _onTimeSelector(key);
                        },
                        child: Container(
                          width: 45,
                          height: 40,
                          child: _monthKey == key
                              ? Icon(Icons.done)
                              : Text(
                                  value,
                                  style: TextStyle(fontSize: 10),
                                ),
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            );
          }
          else if (index == 1) {
            return pie();
          } else {
            return ListTile(
              leading: Icon(menuIcons[index - 2]), //左边
              title: Text(data[index - 2]["name"]), //title
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${data[index - 2]["value"]}元'),
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
