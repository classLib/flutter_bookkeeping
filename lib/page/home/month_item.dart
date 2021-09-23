import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/dao/keepDbHelper.dart';
import 'package:flutter_bookkeeping/model/keepSetting/keep_record.dart';
import 'package:flutter_bookkeeping/page/home/month_detail.dart';

class MonthItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return ListTile(
      title: Text("本月"),
      subtitle: Text("9月1日 - 9月30日"),
      leading: Icon(Icons.calendar_view_month, color: Colors.blueAccent),
      trailing: Icon(Icons.arrow_right),
      onTap: () async {
        List<KeepRecord> list = await KeepDbHelper.queryMonth();
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => MonthDetail(list: list)));
      },
    );
  }
}
