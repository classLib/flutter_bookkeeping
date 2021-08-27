import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/util/constant.dart';
import 'package:flutter_bookkeeping/util/head_util.dart';

/// FileName: username_page
/// Author: hjy
/// Date: 2021/8/9 21:46
/// Description:修改用户名

class UsernamePage extends StatefulWidget {
  const UsernamePage({Key key}) : super(key: key);

  @override
  _UsernamePageState createState() => _UsernamePageState();
}

class _UsernamePageState extends State<UsernamePage> {
  final _normalFont =
      const TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal);
  ///border
  final _borderRadius = BorderRadius.circular(6);

  ///attribute
  bool _isEnableLogin = false;

  //控制账户和密码的输入，获取其内容
  final accountController = TextEditingController();

  // 关闭按钮
  Widget _cancel() {
    // ignore: deprecated_member_use
    return FlatButton(
      color: Theme.of(context).primaryColor,
      child: Text(
        "关闭",
        style: _normalFont,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  ///确认修改按钮
  _getConfirmButtonPressed() {
    if (!_isEnableLogin) return null;
    var oldName = Constant.username, newName = accountController.text;
    Constant.username = newName;
    return () {
      showDialog(
          context: this.context,
          builder: (context) {
            return AlertDialog(
              title: Text("修改信息"),
              content: (oldName == newName ? Text("不能与原用户名相同") : Text("修改成功！")),
              actions: <Widget>[
                _cancel(),
              ],
            );
          });
    };
  }

  /// 检查用户输入
  void _checkUserInput() {
    if (accountController.text.isNotEmpty) {
      if (_isEnableLogin) return;
    } else {
      if (!_isEnableLogin) return;
    }
    setState(() {
      _isEnableLogin = !_isEnableLogin;
    });
  }

  /// 渲染账户输入框
  Widget _buildAccountEditTextField() {
    return Container(
      margin: EdgeInsets.only(top: 50, left: 25, right: 25),
      child: TextField(
        controller: accountController,
        onChanged: (text) => {
          _checkUserInput(),
        },
        decoration: InputDecoration(
          hintText: "请输入新的用户名",
          filled: true,
          fillColor: Color.fromARGB(255, 240, 240, 240),
          contentPadding: EdgeInsets.only(left: 10),
          border: OutlineInputBorder(
              borderRadius: _borderRadius, borderSide: BorderSide.none),
        ),
      ),
    );
  }

  /// 确认按钮
  Widget _buildButtonConfirm() {
    return Container(
        color: themeColorMap[Constant.keyThemeColor],
        margin: EdgeInsets.only(top: 20, left: 25, right: 25),
        width: MediaQuery.of(context).size.width,
        height: 45,
        // ignore: deprecated_member_use
        child: RaisedButton(
          child: Text(
            "确认",
            style: _normalFont,
          ),
          color:Theme.of(context).primaryColor,
          disabledColor: Colors.black12,
          textColor: Colors.white,
          disabledTextColor: Colors.black12,
          shape: RoundedRectangleBorder(borderRadius: _borderRadius),
          onPressed: _getConfirmButtonPressed(),
        ));
  }
  /// 界面
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //脚手架
      appBar: AppBar(
        title: Text(
          "修改用户名",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        // margin: EdgeInsets.only(left: 25, right: 25),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              HeadUtil(),
              _buildAccountEditTextField(),
              _buildButtonConfirm()
            ],
          ),
        ),
      ),
    );
  }
}
