import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'calculator.dart';

import 'category_setting_test.dart';
import 'category_expenditure_add.dart';
/*
* 收入记账的页面
*
*
*
*
* */
class KeepIncome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _KeepIncomeState();
  }

}
class _KeepIncomeState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: RaisedButton(
          child: Text('设置'),
          onPressed:() async {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CategoryHomePage()));
          },
        ),
      ),
    );
  }

}