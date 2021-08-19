import 'package:flutter/material.dart';

class MonthItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("本月"),
      subtitle: Text("8月1日 - 8月31日"),
      leading: Icon(Icons.calendar_view_month, color: Colors.blueAccent),
      trailing: Icon(Icons.arrow_right),
    );
  }
}
