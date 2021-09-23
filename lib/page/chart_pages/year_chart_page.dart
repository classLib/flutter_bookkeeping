import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/dao/keepDbHelper.dart';
import 'package:flutter_bookkeeping/model/keepSetting/keep_record.dart';
import 'package:flutter_bookkeeping/page/chart_pages/handle_list.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';

/// FileName: year_chart_page
/// Author: hjy
/// Date: 2021/8/12 19:34
/// Description:年度报表

class YearChartPage extends StatefulWidget {
  const YearChartPage({Key key}) : super(key: key);

  @override
  _YearChartPageState createState() => _YearChartPageState();
}

class _YearChartPageState extends State<YearChartPage> {
  ///
  ///初始化
  ///
  //找表，查找所有
  Future<List<KeepRecord>> keepRecords;
  List<KeepRecord> keepHistory = [];
  var _yearKey = "2021";
  var choice = 1;
  //年总消费，年支出，年收入
  var yearList = [], yearPay = [], yearIncome = [];
  var data = [
    {"value": 10, "name": 'rose1'},
  ];

  //面积图数据
  List<double> areaData = [
    -6.0,
    -9.0,
    -11.0,
    -12.0,
  ];
  //图标
  List menuIcons = ['assets/canyin.png'];

  @override
  void initState() {
    super.initState();
    //查询所有
    keepRecords = KeepDbHelper.queryAll();
    keepRecords.then((value) {
      setState(() {
        this.keepHistory = value;
      });
    });
  }

  ///
  ///数据处理
  ///
  //选中时间，得到List
  _onTimeSelect(model) {
    Pickers.showDatePicker(context, mode: model, onConfirm: (p) {
      setState(() {
        this._yearKey = '${p.year}';
        this.yearList =
            HandleList().getListData(this.yearList, this.keepHistory, model, p);
      });
      if (this.yearList.isEmpty) {
        Navigator.of(context).pop();
        return showDialog(
            context: this.context,
            builder: (context) {
              return AlertDialog(
                title: Text("报表提醒"),
                content: Text("当年未记账，请重新选择！"),
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
      } else {
        var tmp = HandleList()
            .getDivideData(this.yearPay, this.yearIncome, this.yearList);
        this.yearIncome = tmp[0];
        this.yearPay = tmp[1];

        renderChart(this.yearPay);
      }
    });
  }

  //点击radio按钮选择
  _onRadioChanged(value) {
    setState(() {
      this.choice = value;
    });
    if (value == 1) {
      renderChart(this.yearPay);
    } else {
      renderChart(this.yearIncome);
    }
  }

  ///
  ///图标渲染
  ///
  //南丁格尔
  Widget pie() {
    return Column(
      children: [
        SizedBox(
          height: 5.0,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 60,
            ),
            Text("年支出"),
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
            Text("年收入"),
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
            option: '''
                  {
        tooltip: {
        trigger: 'item',
        formatter: '{a} <br/>{b} : {c} ({d}%)'
    },
    series: [
        {
            type: 'pie',
            radius: [5, 70],
            // center: ['75%', '50%'],
            roseType: 'area',
            data: ${jsonEncode(data)}
        }
    ]
}
                  ''',
          ),
        )
      ],
    );
  }

  //面积图
  Widget area() {
    return Container(
      child: Echarts(
        captureAllGestures: true,
        extraScript: '''
                    var base = +new Date(${jsonDecode(this._yearKey)},0,0);
                    var oneDay = 24 * 3600 * 1000;
                    var date = [];
                    for (var i = 1; i < 365; i++) {
                        var now = new Date(base += oneDay);
                        date.push([now.getFullYear(), now.getMonth() + 1, now.getDate()].join('/'));
                    }
                  ''',
        option: '''
              {
                backgroundColor: 'rgba(255,255,255,0.3)',
                tooltip: {
                    trigger: 'axis',
                    position: function (pt) {
                        return [pt[0], '10%'];
                    }
                },
                toolbox: {
                    feature: {
                        dataZoom: {
                            yAxisIndex: 'none'
                        },
                        restore: {},
                        saveAsImage: {}
                    }
                },
                xAxis: {
                    type: 'category',
                    boundaryGap: false,
                    data: date
                },
                yAxis: {
                    type: 'value',
                    boundaryGap: [0, '100%']
                },
                dataZoom: [{
                    type: 'inside',
                    start: 60,
                    end: 70
                }, {
                    start: 0,
                    end: 10,
                    handleIcon: 'M10.7,11.9v-1.3H9.3v1.3c-4.9,0.3-8.8,4.4-8.8,9.4c0,5,3.9,9.1,8.8,9.4v1.3h1.3v-1.3c4.9-0.3,8.8-4.4,8.8-9.4C19.5,16.3,15.6,12.2,10.7,11.9z M13.3,24.4H6.7V23h6.6V24.4z M13.3,19.6H6.7v-1.4h6.6V19.6z',
                    handleSize: '80%',
                    handleStyle: {
                        color: '#fff',
                        shadowBlur: 3,
                        shadowColor: 'rgba(0, 0, 0, 0.6)',
                        shadowOffsetX: 2,
                        shadowOffsetY: 2
                    }
                }],
                series: [
                    {
                        name: 'data',
                        type: 'line',
                        smooth: true,
                        symbol: 'none',
                        sampling: 'average',
                        itemStyle: {
                            color: 'rgb(255, 70, 131)'
                        },
                        areaStyle: {
                            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                                offset: 0,
                                color: 'rgb(255, 158, 68)'
                            }, {
                                offset: 1,
                                color: 'rgb(255, 70, 131)'
                            }])
                        },
                        data: ${jsonEncode(areaData)}
                    }
                ],
                grid:{
                  x:40,
                }
              }
              ''',
      ),
      width: 300,
      height: 250,
    );
  }

  //渲染图表
  renderChart(list) {
    setState(() {
      this.data = HandleList().handlePie(list, this.data)[0];
      this.areaData =
          HandleList().handleAreaData(list, this._yearKey, this.areaData);
      this.menuIcons = HandleList().handleIcon(list, this.menuIcons);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: ListView.separated(
          itemCount: data.length + 3,
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return ListTile(
                onTap: () {
                  _onTimeSelect(DateMode.Y);
                },
                title: Text("选择年度"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("${this._yearKey}"),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              );
            }
            else if (index == 1) {
              return pie();
            }
            else if (index == 2) {
              return area();
            }
            else
              return ListTile(
                leading: Image.asset(this.menuIcons[index - 3]), //左边
                title: Text(data[index - 3]["name"]), //title
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${data[index - 3]["value"]}元'),
                  ],
                ),
              );
          },
        ));
  }
}
