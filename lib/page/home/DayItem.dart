import 'package:flutter/material.dart';

class DayItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text("今日"),
        subtitle: Text("无"),
        leading: Icon(Icons.calendar_view_day, color: Colors.lightBlue),
        trailing: Icon(Icons.arrow_right));
  }
}
