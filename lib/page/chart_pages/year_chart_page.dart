import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  //饼图
  Widget pie(){
    return Container(
      width: 300,
      height: 250,
      child: Echarts(
        option: '''
                  {
                      backgroundColor: 'white',
                      tooltip: {
                          trigger: 'item',
                          formatter: '{b} <br/> {c} ({d}%)'
                      },
                      visualMap: {
                          show: false,
                          min: 80,
                          max: 600,
                          inRange: {
                              colorLightness: [0, 1]
                          }
                      },
                      series: [
                          {
                              type: 'pie',
                              radius: '55%',
                              center: ['50%', '50%'],
                              data: data.sort(function (a, b) { return a.value - b.value; }),
                              roseType: 'radius',
                              label: {
                                  color: 'black'
                              },
                              labelLine: {
                                  lineStyle: {
                                      color: 'black'
                                  },
                                  smooth: 0.2,
                                  length: 8,
                                  length2: 10
                              },
                              itemStyle: {
                                  color: '#c23531',
                                  shadowBlur: 200,
                                  shadowColor: 'rgba(0, 0, 0, 0.5)'
                              },
                              animationType: 'scale',
                              animationEasing: 'elasticOut',
                              animationDelay: function (idx) {
                                  return Math.random() * 200;
                              }
                          }
                      ]
                  }
                  ''',
        extraScript: '''
                  var data = [
                      {value: 335, name: '直接访问'},
                      {value: 310, name: '邮件营销'},
                      {value: 274, name: '联盟广告'},
                      {value: 235, name: '视频广告'},
                      {value: 400, name: '搜索引擎'}
                  ]
                  ''',
      ),
    );
  }
  //面积图
  Widget area(){
    return Container(
      child: Echarts(
        captureAllGestures: true,
        extraScript: '''
                    var base = +new Date(1968, 9, 3);
                    var oneDay = 24 * 3600 * 1000;
                    var date = [];

                    var data = [Math.random() * 300];

                    for (var i = 1; i < 20000; i++) {
                        var now = new Date(base += oneDay);
                        date.push([now.getFullYear(), now.getMonth() + 1, now.getDate()].join('/'));
                        data.push(Math.round((Math.random() - 0.5) * 20 + data[i - 1]));
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
                    start: 0,
                    end: 10
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
                        data: data
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 5.0,),
              Text("各分类占比"),
              SizedBox(height: 5.0,),
              pie(),
              SizedBox(height: 10,),
              Text("面积图"),
              area(),
            ],
          ),
        ),
      ),
    );
  }
}
