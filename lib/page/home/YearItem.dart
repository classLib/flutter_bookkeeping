import 'package:flutter/material.dart';

class YearItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text("本年"),
        subtitle: Text("2021年"),
        leading: Icon(Icons.date_range, color: Colors.pinkAccent),
        trailing: Icon(Icons.arrow_right));
  }
}
