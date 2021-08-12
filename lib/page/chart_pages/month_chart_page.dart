import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

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
  //饼图
  Widget pie() {
    return Container(
      width: 300,
      height:400,
      child: Echarts(
        option: '''{
        legend: {
        orient: 'vertical',
        left: 10,
        data: legendData
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
            data: data
        }
    ]
}''',
        extraScript: '''
            var data = [
                {value: 335, name: '直接访问'},
                {value: 310, name: '邮件营销'},
                {value: 234, name: '联盟广告'},
                {value: 135, name: '视频广告'},
                {value: 1548, name: '搜索引擎'}
            ];
            var legendData= ['直接访问', '邮件营销', '联盟广告', '视频广告', '搜索引擎']
            ''',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 5.0,
              ),
              Text("各分类占比"),
              SizedBox(
                height: 5.0,
              ),
              pie(),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
