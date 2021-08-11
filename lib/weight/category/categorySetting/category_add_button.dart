// 分类新增按钮,应该是跳转到另外一个页面并返回结果
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef SubmittedCallback = void Function(String value);

class CategoryAddButtonWeight extends StatelessWidget {
  SubmittedCallback submittedCallback;

  CategoryAddButtonWeight(this.submittedCallback);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        child: Text('新增分类'),
        color: Colors.red,
        onPressed: () {
          submittedCallback;
    });
  }
}