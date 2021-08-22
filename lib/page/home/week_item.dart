import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/page/home/week_detail.dart';

class WeekItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("本周"),
      subtitle: Text("8月16日 - 8月22日"),
      leading: Icon(Icons.calendar_view_week, color: Colors.orangeAccent),
      trailing: Icon(Icons.arrow_right),
      onTap: () {
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => WeekDetail()));
      },
    );
  }
}
