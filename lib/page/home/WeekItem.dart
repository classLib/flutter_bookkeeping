import 'package:flutter/material.dart';

class WeekItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text("本周"),
        subtitle: Text("8月16日 - 8月22日"),
        leading: Icon(Icons.calendar_view_week, color: Colors.orangeAccent),
        trailing: Icon(Icons.arrow_right));
  }
}
