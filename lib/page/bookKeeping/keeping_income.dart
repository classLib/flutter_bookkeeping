import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/dao/keepDbHelper.dart';
import 'package:flutter_bookkeeping/model/categorySetting/category.dart';
import 'package:flutter_bookkeeping/model/keepSetting/keep_record.dart';
import 'package:flutter_bookkeeping/test/bookKeeping_database_test.dart';
import 'package:flutter_bookkeeping/util/DbHelper.dart';
import 'package:flutter_bookkeeping/weight/bookKeeping/beiZhuTextControllerWeight.dart';
import 'package:flutter_bookkeeping/weight/bookKeeping/keepTextControllerWeight.dart';
import 'package:flutter_bookkeeping/weight/bookKeeping/timeTextControllerWeight.dart';
import '../../constantWr.dart';
import 'calculator.dart';

import 'category_setting_main.dart';
import 'category_expenditure_add.dart';
/*
* 收入记账的页面
*
*
*
*
// * */

class KeepIncome extends StatefulWidget {
  final DbHelper categoryProvider = new DbHelper();

  @override
  State<StatefulWidget> createState() {
    return new _KeepIncomeState();
  }
}

class _KeepIncomeState extends State<KeepIncome> {
  // 默认的图片编号为1

  var curImageNumString;
  var curCategoryName;
  var curColor = Colors.black12;
  String _key = '';
  // 是否有变化的分类管理
  bool isOnTap = false;

  // 记账钱数
  final _keepTextController = TextEditingController();

  //  备注
  final _beiZhuTextController = TextEditingController();

  //  日期
  final _timeTextController = TextEditingController();


  double _keepText = 0.00;
  String _beiZhuText = '';
  String _timeText = '';

  List<Catetory> _historyWords = CategoryImage.inComeCategory;




  // String get calculator => null;

//  初始化
  @override
  void initState() {
    super.initState();
    setState(() {
      _keepText = 0.00;
      _beiZhuText = _beiZhuTextController.text;
      _timeText = _timeTextController.text;
      curImageNumString = '';
      curCategoryName = '';
    });
    _getAllDataFromDb();
    // _init();
  }

  _getAllDataFromDb() async {
    List<Catetory> _tempList  =  await widget.categoryProvider.queryByCategoryBelong(0) ;
    if(_tempList.length > _historyWords.length) {
      _historyWords =  _tempList;
    }
    print(_historyWords);
    print(_historyWords.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 15, right: 15, top: 20),
        child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 900),
            child: Column(
              children: <Widget>[
                ImageListWidget(context),
                KeepTextControllerWeight(_keepTextController),
                TimeTextControllerWeight(_timeTextController),
                BeiZhuTextControllerWeight(_beiZhuTextController),
                _storeButton(),
                // _buildButton()
              ],
            )),
      ),
    );
  }

  // 图片展示
  Widget ImageListWidget(context) {
    return Wrap(
      spacing: 23, //主轴上子控件的间距
      runSpacing: 15, //交叉轴上子控件之间的间距
      children: _listView(context), //要显示的子控件集合
    );
  }

  // 图片组件
  List<Widget> _listView(context) {
    List<Widget> listWidget = [];
    // 访问数据库，得到所有的分类对象
    _historyWords.forEach((e) => {listWidget.add(listItem(e))});
    return listWidget;
  }

  Widget listItem(item) {
    return InkWell(
        onTap: () {
          setState(() {
            // // 更新全局所选的id
            curImageNumString = item.category_inmage_num;
            curCategoryName = item.category_name;
            _key = item.category_name;
            print(curImageNumString);
            print(curCategoryName);
          });
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
                decoration: new BoxDecoration(
                  // 点击之后的
                  color: _key == item.category_name ? Colors.black12 : Colors.white54,
                ),
                child: Column(children: <Widget>[
                  Image.asset(
                    item.category_inmage_num,
                    width: 60,
                    height: 50,
                  ),
                  Text(
                    item.category_name,
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 22, 22, 78),
                        // decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.solid),
                  ),
                ]))));
  }


  // 保存按钮
  Widget _storeButton() {
    return Container(
        margin: EdgeInsets.only(left: 100, right: 15, top: 20),
        child: Row(
          children: [
            FlatButton(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryHomePage()));
              },
              child: Text("分类管理"),
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(15)),
            ),
            FlatButton(
              onPressed: () async {
                // 存储所有的数据到数据库
                print(curImageNumString);
                print(curCategoryName);

                double _keepText =
                double.parse(_keepTextController.text) == 0.00
                    ? 0.00
                    : double.parse(_keepTextController.text);
                String _beiZhuText = _beiZhuTextController.text == ''
                    ? '无'
                    : _beiZhuTextController.text;
                print(_beiZhuText);
                String _timeText = _timeTextController.text;
                print(_timeText);

                KeepRecord keepRecord = new KeepRecord(curCategoryName, 0,
                    _timeText, curImageNumString, _beiZhuText, _keepText);
                var id = await KeepDbHelper.insert(keepRecord);

                // 清空输入框
                _keepTextController.clear();
                _timeTextController.clear();
                _beiZhuTextController.clear();

                // 跳转返回另外一个页面
              },
              child: Text("保存"),
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(15)),
            ),

          ],
        ));
  }
}
