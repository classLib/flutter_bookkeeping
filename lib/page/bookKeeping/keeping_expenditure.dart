import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/dao/keepDbHelper.dart';
import 'package:flutter_bookkeeping/model/keepSetting/keep_record.dart';
import 'package:flutter_pickers/pickers.dart';
import 'calculator.dart';
import 'package:flutter_bookkeeping/util/DbHelper.dart';
import 'package:flutter_bookkeeping/model/categorySetting/category.dart';

import '../../constantWr.dart';
import 'category_setting_test.dart';

/*
* 记账支出的页面
*
*
*
*
* */
class KeepExpenditure extends StatefulWidget {
  final DbHelper keepProvider = new DbHelper();

  @override
  State<StatefulWidget> createState() {
    return new _KeepExpenditureState();
  }
}

class _KeepExpenditureState extends State<KeepExpenditure> {
  // 默认的图片编号为1

  var curImageNumString;
  var curCategoryName;
  var curColor = Colors.black12;
  int _key;

  // 记账钱数
  final _keepTextController = TextEditingController();

  //  备注
  final _beiZhuTextController = TextEditingController();

  //  日期
  final _timeTextController = TextEditingController();

  FocusNode _commentFocus = FocusNode();

  double _keepText = 0;
  String _beiZhuText = '';
  String _timeText = '';

  List<Catetory> _historyWords = [];

  //  默认的一些配置
  final marginSetting = EdgeInsets.fromLTRB(0, 15, 0, 0);

  String get calculator => null;

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
    _historyWords = await widget.keepProvider.queryAll();
    // await widget.categoryProvider.deleteAll();
    _historyWords.forEach((element) {
      print(element.category_inmage_num);
    });
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
                _keepTextControllerWeight(),
                _timeTextControllerWeight(),
                _beiZhuTextControllerWeight(),
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
            _key = item.id;
            print(curImageNumString);
            print(curCategoryName);
          });
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
                decoration: new BoxDecoration(
                  // 点击之后的
                  color: _key == item.id ? Colors.black12 : Colors.white54,
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

  // 计算器和记账

  Widget _keepTextControllerWeight() {
    return Container(
      margin: marginSetting, //外边距，父容器本身相对外部容器的移动
      child: Container(
        height: 50,
        constraints: BoxConstraints(maxHeight: 56, minHeight: 56),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFE8E8E8),
              width: 2,
            ),
          ),
        ),
        child: TextField(
          focusNode: _commentFocus,
          controller: _keepTextController,
          style: TextStyle(fontSize: 15, color: Colors.black87), //文字大小、颜色
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              /*边角*/
              borderRadius: BorderRadius.all(
                Radius.circular(20), //边角为30
              ),
              borderSide: BorderSide(
                color: Colors.blue, //边线颜色为黄色
                width: 2, //边线宽度为2
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.lightBlue, //边框颜色为绿色
              width: 2, //宽度为5
            )),
            labelText: "请输入钱数",
            helperStyle: TextStyle(color: Colors.red),
            prefixIconConstraints: BoxConstraints(),
            prefixIcon: InkWell(
              child: Container(
                child: Image.asset(
                  'assets/licaitouzi.png',
                  width: 30,
                  height: 40,
                ),
              ),
              onTap: () async {
                showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Column(
                        children: [Expanded(child: Calculator())],
                      );
                    });
                final result = await Navigator.pushNamed(context, calculator);
              },
            ),
          ),
        ),
      ),
    );
  }

  _onCallback() {}

//  日期文本框
  Widget _timeTextControllerWeight() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 25, 0, 0), //外边距，父容器本身相对外部容器的移动
      child: Container(
        height: 50,
        constraints: BoxConstraints(maxHeight: 56, minHeight: 56),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFE8E8E8),
              width: 1,
            ),
          ),
        ),
        child: TextField(
          onTap: () {
            _showDatePicker2();
          },
          controller: _timeTextController,
          style: TextStyle(fontSize: 15, color: Colors.black87), //文字大小、颜色
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.lightBlue, //边框颜色为绿色
              width: 2,
            )),
            labelText: "日期",
            helperStyle: TextStyle(color: Colors.red),
            prefixIconConstraints: BoxConstraints(
                //添加内部图标之后，图标和文字会有间距，实现这个方法，不用写任何参数即可解决
                ),
            prefixIcon: Image.asset(
              'assets/rili2.png',
              width: 30,
              height: 40,
            ),
          ),
        ),
      ),
    );
  }

  Future<DateTime> _showDatePicker2() {
    var date = DateTime.now();
    return showCupertinoModalPopup(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      context: context,
      builder: (ctx) {
        return SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            use24hFormat: true,
            mode: CupertinoDatePickerMode.dateAndTime,
            minimumDate: date,
            maximumDate: date.add(
              Duration(days: 30),
            ),
            maximumYear: date.year + 1,
            onDateTimeChanged: (DateTime value) {
              // 将value值回调给前面的输入框
              print(value);
              int size = value.toString().length - 7;
              setState(() {
                _timeTextController.text = value.toString().substring(0, size);
                _timeText = value.toString();
              });
            },
          ),
        );
      },
    );
  }

//  备注文本框
  Widget _beiZhuTextControllerWeight() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 25, 0, 0), //外边距，父容器本身相对外部容器的移动
      child: Container(
        height: 50,
        constraints: BoxConstraints(maxHeight: 56, minHeight: 56),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFE8E8E8),
              width: 1,
            ),
          ),
        ),
        child: TextField(
          controller: _beiZhuTextController,
          style: TextStyle(fontSize: 15, color: Colors.black87), //文字大小、颜色
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              /*边角*/
              borderRadius: BorderRadius.all(
                Radius.circular(20), //边角为30
              ),
              borderSide: BorderSide(
                color: Colors.blue, //边线颜色为黄色
                width: 2, //边线宽度为2
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.lightBlue, //边框颜色为绿色
              width: 2, //宽度为5
            )),
            labelText: "写点备注吧",
            helperStyle: TextStyle(color: Colors.red),
            prefixIconConstraints: BoxConstraints(
                //添加内部图标之后，图标和文字会有间距，实现这个方法，不用写任何参数即可解决
                ),
            prefixIcon: Image.asset(
              // 'assets/beizhu_1.png' ,
              'assets/beizhu_1.png',
              width: 30,
              height: 30,
            ),
          ),
        ),
      ),
    );
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
                String _timeText = _timeTextController.text;

                KeepRecord keepRecord = new KeepRecord(curCategoryName, 1,
                    _timeText, curImageNumString, _beiZhuText, _keepText);
                var id = await KeepDbHelper.insert(keepRecord);
                // Future<List<KeepRecord>>list =  KeepDbHelper.queryAll();
                // List<KeepRecord> history = [];
                // list.then((value){
                //   setState(() {
                //     value.forEach((each) {
                //       history.add(each);
                //       print(value[0]);
                //     });
                //   });
                // });
                // print(Kee)
                // 清空输入框
                _keepTextController.clear();
                _timeTextController.clear();
                _beiZhuTextController.clear();

                // 跳转返回另外一个页面
              },
              child: Text("保存"),
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
        ));
  }
}
