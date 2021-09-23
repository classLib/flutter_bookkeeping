import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/page/home/day_item.dart';
import 'package:flutter_bookkeeping/page/home/month_item.dart';
import 'package:flutter_bookkeeping/page/home/week_item.dart';
import 'package:flutter_bookkeeping/page/home/year_item.dart';
import 'package:flutter_bookkeeping/page/home/image_item/image_item.dart';

class BillListView extends StatelessWidget {
  const BillListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [
      ImageItem(
        imageUrl: 'assets/home_bg_1.jpg',
        expendQuota: 526.5,
        incomeQuota: 301.0,
      ),
      DayItem(),
      WeekItem(),
      MonthItem(),
      YearItem()
    ];

    return ListView.separated(
        itemCount: 5,
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemBuilder: (BuildContext context, int index) {
          return items[index];
        });
  }
}
