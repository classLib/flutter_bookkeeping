// 分类管理的支出页面
/*
* 1.调用数据库查询所有支出的（category_belong = 1），进行展示
* 2.展示分类图片 + 分类名称 + 删除符号
*
* */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/model/categorySetting/category.dart';
import 'package:flutter_bookkeeping/util/DbHelper.dart';
import '../Bookkeeping.dart';
import 'category_expenditure_add.dart';
import 'category_income_add.dart';

class Ewxpenditure extends StatefulWidget {
  final chooseType;
  final DbHelper categoryProvider = new DbHelper();

  Ewxpenditure({Key key, this.chooseType}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _Ewxpenditure();
  }
}

class _Ewxpenditure extends State<Ewxpenditure> {
  int currentItem = 1; // 新增本行
// final chooseType;
  List dataList = [];

  List<Catetory> _sumCategory = []; //存储搜索历史
  @override
  void initState() {
    super.initState();
    _getDataFrom();
  }

  _getDataFrom() async {
    _sumCategory =  await widget.categoryProvider.queryByCategoryBelong(1);
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
              // Spacer(),  // 不需要滑动的页面可以直接用这个
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
                              builder: (context) => CategoryExpenditureAdd()));
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
