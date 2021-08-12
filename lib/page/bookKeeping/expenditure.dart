// 分类管理的支出页面
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'category_expenditure_add.dart';
import 'category_income_add.dart';

class Ewxpenditure extends StatefulWidget {
  final chooseType;

  const Ewxpenditure({Key key, this.chooseType}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _Ewxpenditure();
  }
}

class _Ewxpenditure extends State<Ewxpenditure> {
  int currentItem = 1; // 新增本行
// final chooseType;
  final List dataList = [
    {'id': 1, 'title': '表单名称1'},
    {'id': 2, 'title': '表单名称2'},
    {'id': 3, 'title': '表单名称3'},
    {'id': 4, 'title': '表单名称3'},
    {'id': 5, 'title': '表单名称3'},
    {'id': 6, 'title': '表单名称3'},
    {'id': 7, 'title': '表单名称3'},
    {'id': 8, 'title': '表单名称3'},
    {'id': 9, 'title': '表单名称3'},
    {'id': 10, 'title': '表单名称3'},
    {'id': 11, 'title': '表单名称3'},
    {'id': 12, 'title': '表单名称12'},
  ];

  List<Widget> _listView(context) {
    List<Widget> listWidget = [];
    // final bool alreadySaved = _saved.contains(e['id']);
    dataList.map((e) => {listWidget.add(listItem(e))}).toList();
    return listWidget;
  }

  Widget listItem(item) {
    // print(item);
    final bool alreadySaved = currentItem == item['id'];
    return ListTile(
        title: Text(item['title']),
        onTap: () {
          setState(() {
            currentItem = item['id'];
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  // 这个页面是要滑动的，所以用Expanded
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _listView(context),
                ),
              )),
              // Spacer(),  // 不需要滑动的页面可以直接用这个
              RaisedButton(
                  child: Text('新增分类'),
                  color: Colors.blue,
                  onPressed: () async {
                    Navigator.push(
                        context,
                        // 分类管理页面点击新增分类跳转到分类新增新增页面
                        MaterialPageRoute(
                            builder: (context) => CategoryExpenditureAdd()));
                  }),
            ]),
      ),
    );
  }
}
