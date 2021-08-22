import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/page/home/day_detail.dart';

class DayItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("今日"),
      subtitle: Text("无"),
      leading: Icon(Icons.calendar_view_day, color: Colors.lightBlue),
      trailing: Icon(Icons.arrow_right),
      onTap: () {
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => DayDetail()));
      },
    );
  }
}
