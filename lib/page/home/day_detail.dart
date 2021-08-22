import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/page/home/image_item/image_item.dart';

class DayDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [
      ImageItem(
        imageUrl: 'assets/home_bg_2.jpg',
        expendQuota: 17.5,
        incomeQuota: 301.0,
      ),
      ListTile(
        title: Text("工资收入"),
        subtitle: Text("2021.8.19 19:55"),
        leading: Icon(Icons.calendar_view_day, color: Colors.lightBlue),
        trailing: Icon(Icons.arrow_right),
      ),
      ListTile(
        title: Text("公共交通"),
        subtitle: Text("2021.8.19 17:55"),
        leading: Icon(Icons.calendar_view_day, color: Colors.lightBlue),
        trailing: Icon(Icons.arrow_right),
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("今日账单"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.separated(
        itemCount: items.length,
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
