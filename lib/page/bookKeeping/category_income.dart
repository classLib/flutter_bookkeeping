//分类管理的收入页面

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/model/categorySetting/category.dart';
import 'package:flutter_bookkeeping/util/DbHelper.dart';

import 'category_expenditure_add.dart';
import 'category_income_add.dart';
//
// class InCome extends StatefulWidget {
//   InCome({Key key, this.chooseType}) : super(key: key);
//
//   final chooseType;
//
//   @override
//   State<StatefulWidget> createState() {
//     return new _InComeState();
//   }
//
// }
//
// class _InComeState extends State<InCome> {
//   int currentItem = 1; // 新增本行
// // final chooseType;
//   final List dataList = [
//     {'id': 1, 'title': '表单名称1'},
//     {'id': 2, 'title': '表单名称2'},
//   ];
//
//   List<Widget> _listView(context) {
//     List<Widget> listWidget = [];
//     // final bool alreadySaved = _saved.contains(e['id']);
//     dataList.map((e) =>
//     {
//       listWidget.add(
//           listItem(e)
//       )
//     }).toList();
//     return listWidget;
//   }
//
//   Widget listItem(item) {
//     // print(item);
//     final bool alreadySaved = currentItem == item['id'];
//     return ListTile(
//         title: Text(item['title']),
//
//         onTap: () {
//           setState(() {
//             currentItem = item['id'];
//           });
//         }
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body:
//         Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//           Expanded( // 这个页面是要滑动的，所以用Expanded
//               child:SingleChildScrollView(
//                 child:
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: _listView(context),
//                 ),
//               )
//           ),
//           // Spacer(),  // 不需要滑动的页面可以直接用这个
//           RaisedButton(
//              child: Text('新增分类'),
//              color: Colors.red,
//              onPressed: () async {
//                Navigator.push(
//                    context,
//                    // 分类管理页面点击新增分类跳转到分类新增新增页面
//                    MaterialPageRoute(
//                        builder: (context) => CategoryIncomeAdd()));
//              },
//         ),
//         ]
//     ),
//     ),
//     );
//
//   }
//
// }

class InCome extends StatefulWidget {
  final chooseType;
  final DbHelper categoryProvider = new DbHelper();

  InCome({Key key, this.chooseType}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _InComeState();
  }
}

class _InComeState extends State<InCome> {
  int currentItem = 1; // 新增本行
  List dataList = [];

  List<Catetory> _sumCategory = []; //存储搜索历史
  @override
  void initState() {
    super.initState();
    _getDataFrom();
  }

  _getDataFrom() async {
    _sumCategory = await widget.categoryProvider.queryByCategoryBelong(0);
    print(_sumCategory.length);
    setState(() {
      dataList = _sumCategory;
    });
  }

  List<Widget> _listView(context) {
    List<Widget> listWidget = [];
    // final bool alreadySaved = _saved.contains(e['id']);
    dataList.map((e) => {listWidget.add(listItem(e))}).toList();
    return listWidget;
  }

  Widget listItem(item) {
    return ListTile(
      // 图片
        leading: Image.asset(
          item.category_inmage_num,
          width: 40,
          height: 40,
        ),
        title: Text(item.category_name),
        onTap: () {
          setState(() {
            currentItem = item.id;
            print(item.category_inmage_num);
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
              Container(
                  margin: EdgeInsets.only(left: 100, right: 15, top: 20),
                  child: Row(
                    children: [
                      FlatButton(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        child: Text("返回记账"),
                        color: Colors.blue,
                        textColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      FlatButton(
                        onPressed: () async {
                          Navigator.push(
                              context,
                              // 分类管理页面点击新增分类跳转到分类新增新增页面
                              MaterialPageRoute(
                                  builder: (context) => CategoryIncomeAdd()));
                        },
                        child: Text("新增分类"),
                        color: Colors.blue,
                        textColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ],
                  ))
            ]),
      ),
    );
  }
}
