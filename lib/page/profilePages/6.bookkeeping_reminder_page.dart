import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/util/constant.dart';
import 'package:flutter_bookkeeping/util/head_util.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';

/// FileName: 5.bookkeeping_reminder_page
/// Author: hjy
/// Date: 2021/8/10 17:33
/// Description:记账提醒页面

class BookKeepingReminderPage extends StatefulWidget {
  const BookKeepingReminderPage({Key key}) : super(key: key);

  @override
  _BookKeepingReminderPageState createState() =>
      _BookKeepingReminderPageState();
}

class _BookKeepingReminderPageState extends State<BookKeepingReminderPage> {
  var time = "暂无";
  bool backUp = false;

  //点击选中时间
  _onTimeSelect(model) {
    Pickers.showDatePicker(context, mode: model, onConfirm: (p) {
      setState(() {
        time = '${p.hour}:${p.minute}';
      });
    });
  }

  _onBackUp(){
    if(this.backUp == true){
      DateTime _nowDate=DateTime.now();
      var cur = "${_nowDate.hour}:${_nowDate.minute}";
      // if(cur == time) {
      //
      // }
    }
  }
  //时间选择器
  Widget _timeSelector(title, model) {
    return Container(
      color: Colors.white,
      child: ListTile(
        onTap: () {
          _onTimeSelect(model);
        },
        title: Text(title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[Text(time), Icon(Icons.arrow_forward_ios)],
        ),
      ),
    );
  }

  //系统提醒
  Widget _systemSwitch() {
    return ListTile(
      title: Text("系统提醒"), //title
      trailing: Switch(
        value: this.backUp,
        activeColor: Theme.of(context).accentColor,
        onChanged: (value) {
          setState(() {
            this.backUp = value;
            _onBackUp();
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("记账提醒"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        children: [
          HeadUtil(),
          _systemSwitch(),
          _timeSelector("提醒时间", DateMode.HM)
        ],
      ),
    );
  }
}
