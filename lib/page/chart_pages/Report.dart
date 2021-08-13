import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';


class ReportPage extends StatefulWidget {
  const ReportPage({Key key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final options = {
    "xAxis": {
      "type": 'category',
      "data": ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
    },
    "yAxis": {"type": 'value'},
    "series": [
      {
        "data": [820, 932, 901, 934, 1290, 1330, 1320],
        "type": 'line'
      }
    ]
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EChart1 - 平滑折线图 警戒线'),
      ),
      body: Container(
        child: Echarts(
          option: '''
    {
      xAxis: {
        type: 'category',
        data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
      },
      yAxis: {
        type: 'value'
      },
      series: [{
        data: [820, 932, 901, 934, 1290, 1330, 1320],
        type: 'line'
      }]
    }
  ''',
        ),
        width: 300,
        height: 250,
      ),
    );
  }
}
