import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/dao/keepDbHelper.dart';
import 'package:flutter_bookkeeping/model/keepSetting/keep_record.dart';
import 'package:flutter_bookkeeping/page/home/year_detail.dart';

class YearItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("本年"),
      subtitle: Text("2021年"),
      leading: Icon(Icons.date_range, color: Colors.pinkAccent),
      trailing: Icon(Icons.arrow_right),
      onTap: () async {
        List<KeepRecord> list = await KeepDbHelper.queryYear();
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => YearDetail(list: list)));
      },
    );
  }
}
