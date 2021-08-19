import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/page/home/DayItem.dart';
import 'package:flutter_bookkeeping/page/home/MonthItem.dart';
import 'package:flutter_bookkeeping/page/home/WeekItem.dart';
import 'package:flutter_bookkeeping/page/home/YearItem.dart';

class BillListView extends StatelessWidget {
  const BillListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [DayItem(), WeekItem(), MonthItem(), YearItem()];

    return ListView.separated(
        itemCount: 4,
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemBuilder: (BuildContext context, int index) {
          return items[index];
        });
  }
}
