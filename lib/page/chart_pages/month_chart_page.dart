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
  ];
  //饼图图例
  var legendData = ['餐饮'];

  //日历图数据
  var dateList = [
    ['2017-1-1', '100'],
  ];
  int choice = 1;
  var heatmapData = [];
  var lunarData = [];

  List menuIcons = ['assets/canyin.png'];

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

  //图标,this.menuIcons
  handleIcon(List month) {
    this.menuIcons.clear();
    for (var item in month) {
      this.menuIcons.add(item.recordImage);
    }
  }

  //得到日历图数据,['2017-1-3', '1'],
  handleCalenderData(List month) {
    this.dateList.clear();
    for (var i = 1; i <= 31; i++) {
      this.dateList.add([
        "${DateTime.parse(month[0].recordTime).year}-${DateTime.parse(month[0].recordTime).month}-$i",
        "0"
      ]);
    }
    for (var i = 0; i < month.length; i++) {
      this.dateList[DateTime.parse(month[i].recordTime).day - 1][1] =
          (double.parse(
                      this.dateList[DateTime.parse(month[i].recordTime).day - 1]
                          [1]) +
                  month[i].recordNumber)
              .toString();
    }
  }

  //处理日历图日期列表
  getCalenderDate(List dateList, List heatmapData, List lunarData) {
    for (var i = 0; i < dateList.length; i++) {
      heatmapData.add([dateList[i][0], dateList[i][1]]);
      lunarData
          .add([dateList[i][0].toString(), 1, dateList[i][1].toString(), 0]);
    }
  }

  //处理饼图数据，this.data
  handlePie(List month) {
    this.legendData.clear();
    this.legendData = Set<String>.from(
        month.asMap().keys.map((i) => month[i].recordCategoryName)).toList();
    this.data.clear();
    for (var i = 0; i < this.legendData.length; i++) {
      this.data.add({"value": 0, "name": this.legendData[i]});
    }
    for (var i = 0; i < month.length; i++) {
      for (var j = 0; j < this.legendData.length; j++) {
        if (month[i].recordCategoryName == this.legendData[j]) {
          this.data[j]["value"] =
              double.parse(this.data[j]["value"].toString()) +
                  month[i].recordNumber;
        }
      }
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
        //  得到饼图数据
        handlePie(monthPay);
        // 得到日历图数据
        handleCalenderData(monthPay);
        handleIcon(monthPay);
      });
    } else {
      //  筛选月收入消费
      setState(() {
        //  得到饼图数据
        handlePie(monthIncome);
        // 得到日历图数据
        handleCalenderData(monthIncome);
        handleIcon(monthPay);
      });
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
    this.monthIncome.clear();
    this.monthPay.clear();
    for (var item in this.monthList) {
      if (item.recordCategoryNum == 1) {
        this.monthPay.add(item);
      } else {
        this.monthIncome.add(item);
      }
    }
    setState(() {
      //  得到饼图数据
      handlePie(monthPay);
      // 得到日历图数据
      handleCalenderData(monthPay);
      handleIcon(monthPay);
    });
  }

  //点击选中时间
  _onTimeSelect(model) {
    Pickers.showDatePicker(context, mode: model, onConfirm: (p) {
      setState(() {
        this._monthKey = '${p.year}年${p.month}月';
        this.range = ['${p.year}-${p.month}'];
        //this.keepHistory中找到这一年这一月
        this.monthList.clear();
        for (var each in this.keepHistory) {
          var year = DateTime.parse(each.recordTime).year;
          var month = DateTime.parse(each.recordTime).month;
          if (year == p.year && month == p.month) {
            this.monthList.add(each);
          }
        }
        if (this.monthList.isEmpty) {
          Navigator.of(context).pop();
          return showDialog(
              context: this.context,
              builder: (context) {
                return AlertDialog(
                  title: Text("报表提醒"),
                  content: Text("该月未记账，请重新选择！"),
                  actions: [
                    FlatButton(
                      color: Colors.blue,
                      child: Text(
                        "取消",
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        } else{
          handleMonth();
        }
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
              leading: Image.asset(this.menuIcons[index - 3]), //左边
              title: Text(this.data[index - 3]["name"]), //title
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${this.data[index - 3]["value"]}元'),
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
