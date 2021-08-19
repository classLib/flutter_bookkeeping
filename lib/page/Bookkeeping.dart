import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/test/bookKeeping_database_test.dart';

import 'bookKeeping/categorySetting_add.dart';
import 'bookKeeping/categorySettingTest.dart';

class BookkeepingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('设置'),
        onPressed:() async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookKeepingDdatabaseTest()));
        },
      ),
    );
  }
}