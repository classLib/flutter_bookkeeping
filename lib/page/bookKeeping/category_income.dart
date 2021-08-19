//分类管理的收入页面

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'category_income_add.dart';

class InCome extends StatefulWidget {
  InCome({Key key, this.chooseType}) : super(key: key);

  final chooseType;

  @override
  State<StatefulWidget> createState() {
    return new _InCome();
  }

}

class _InCome extends State<InCome> {
  int currentItem = 1; // 新增本行
// final chooseType;
  final List dataList = [
    {'id': 1, 'title': '表单名称1'},
    {'id': 2, 'title': '表单名称2'},
  ];

  List<Widget> _listView(context) {
    List<Widget> listWidget = [];
    // final bool alreadySaved = _saved.contains(e['id']);
    dataList.map((e) =>
    {
      listWidget.add(
          listItem(e)
      )
    }).toList();
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
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
          Expanded( // 这个页面是要滑动的，所以用Expanded
              child:SingleChildScrollView(
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _listView(context),
                ),
              )
          ),
          // Spacer(),  // 不需要滑动的页面可以直接用这个
          RaisedButton(
             child: Text('新增分类'),
             color: Colors.red,
             onPressed: () async {
               Navigator.push(
                   context,
                   // 分类管理页面点击新增分类跳转到分类新增新增页面
                   MaterialPageRoute(
                       builder: (context) => CategoryIncomeAdd()));
             },
        ),
        ]
    ),
    ),
    );

  }

}