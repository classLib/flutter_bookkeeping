import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/page/home/image_item/image_item.dart';

class WeekDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [
      ImageItem(
        imageUrl: 'assets/home_bg_4.jpg',
        expendQuota: 17.5,
        incomeQuota: 301.0,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("本周账单"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.separated(
        itemCount: 1,
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemBuilder: (BuildContext context, int index) {
          return items[index];
        },
      ),
    );
  }
}
