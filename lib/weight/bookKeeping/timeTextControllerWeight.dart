import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TimeTextControllerWeight extends StatefulWidget{

  TextEditingController timeTextController = TextEditingController();

  TimeTextControllerWeight(this.timeTextController);
  @override
  State<StatefulWidget> createState() {
    return new _TimeTextControllerWeightState(this.timeTextController);
  }

}
class _TimeTextControllerWeightState extends State<TimeTextControllerWeight> {
  TextEditingController timeTextController = TextEditingController();

  _TimeTextControllerWeightState(this.timeTextController) :super();

  @override
  void initState() {
    super.initState();
    setState(() {
      timeTextController.text = '';
    });
    // _init();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 25, 0, 0), //外边距，父容器本身相对外部容器的移动
      child: Container(
        height: 50,
        constraints: BoxConstraints(maxHeight: 56, minHeight: 56),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFE8E8E8),
              width: 1,
            ),
          ),
        ),
        child: TextField(
          onTap: () {
            _showDatePicker2(context);
          },
          controller: timeTextController,
          style: TextStyle(fontSize: 15, color: Colors.black87), //文字大小、颜色
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.lightBlue, //边框颜色为绿色
                  width: 2,
                )),
            labelText: "日期",
            helperStyle: TextStyle(color: Colors.red),
            prefixIconConstraints: BoxConstraints(
              //添加内部图标之后，图标和文字会有间距，实现这个方法，不用写任何参数即可解决
            ),
            prefixIcon: Image.asset(
              'assets/rili2.png',
              width: 30,
              height: 40,
            ),
          ),
        ),
      ),
    );
  }
  Future<DateTime> _showDatePicker2(context) {
    var date = DateTime.now();
    return showCupertinoModalPopup(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      context: context,
      builder: (ctx) {
        return SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            use24hFormat: true,
            mode: CupertinoDatePickerMode.dateAndTime,
            minimumDate: date.add(
              Duration(days: -3600),
            ),
            maximumDate: date.add(
              Duration(days: 3600),
            ),
            maximumYear: date.year + 20,
            onDateTimeChanged: (DateTime value) {
              // 将value值回调给前面的输入框
              print(value);
              int size = value.toString().length - 7;
              setState(() {
                timeTextController.text = value.toString().substring(0, size);
              });
            },
          ),
        );
      },
    );
  }

}

