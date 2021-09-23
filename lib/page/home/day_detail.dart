import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/model/keepSetting/keep_record.dart';
import 'package:flutter_bookkeeping/page/home/image_item/image_item.dart';
import 'package:flutter_bookkeeping/page/home/record_item.dart';

class DayDetail extends StatelessWidget {
  DayDetail({this.list});

  final List<KeepRecord> list;

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [
      ImageItem(
        imageUrl: 'assets/home_bg_2.jpg',
        expendQuota: 0.00,
        incomeQuota: 0.00,
      ),
    ];

    for (int i = 0; i < list.length; i++) {
      KeepRecord record = list[i];
      items.add(
        RecordItem(
            recordType: record.recordCategoryNum,
            category: record.recordCategoryName,
            remark: record.recordTime,
            imageUrl: record.recordImage,
            quota: record.recordNumber),
      );
    }

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
