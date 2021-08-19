import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/util/constant.dart';
import 'package:flutter_bookkeeping/util/head_util.dart';

/// FileName: password_page
/// Author: hjy
/// Date: 2021/8/9 21:45
/// Description: 修改密码

class PasswordPage extends StatefulWidget {
  const PasswordPage({Key key}) : super(key: key);

  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  ///attribute
  bool _isEnableLogin = false;
  bool _obsecureText = true;
  bool _obsecureText1 = true;
  bool _obsecureText2 = true;

  ///border
  final _borderRadius = BorderRadius.circular(6);
  //控制密码的输入，获取其内容
  final pwdController = TextEditingController();
  final pwdController1 = TextEditingController();
  final pwdController2 = TextEditingController();

  /// 检查用户输入
  void _checkUserInput() {
    if (pwdController.text.isNotEmpty &&
        pwdController1.text.isNotEmpty &&
        pwdController2.text.isNotEmpty) {
      if (_isEnableLogin) return;
    } else {
      if (!_isEnableLogin) return;
    }
    setState(() {
      _isEnableLogin = !_isEnableLogin;
    });
  }

  //输入原密码
  Widget _passwordOld() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 25, right: 25),
      child: TextField(
        controller: pwdController,
        onChanged: (text) => {_checkUserInput()},
        obscureText: _obsecureText,
        decoration: InputDecoration(
            hintText: "请输入原密码",
            filled: true,
            fillColor: Color.fromARGB(255, 240, 240, 240),
            contentPadding: EdgeInsets.only(left: 10),
            border: OutlineInputBorder(
                borderRadius: _borderRadius, borderSide: BorderSide.none),
            suffixIcon: IconButton(
              onPressed: () => setState(() => _obsecureText = !_obsecureText),
              icon: _obsecureText ? Icon(Icons.alarm_off) : Icon(Icons.alarm),
              splashColor: Colors.transparent, //去掉点击阴影效果
              highlightColor: Colors.transparent, //去掉点击阴影效果
            )),
      ),
    );
  }

  //第一次输入新密码
  Widget _passwordNew1() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 25, right: 25),
      child: TextField(
        controller: pwdController1,
        onChanged: (text) => {_checkUserInput()},
        obscureText: _obsecureText1,
        decoration: InputDecoration(
            hintText: "请输入新密码",
            filled: true,
            fillColor: Color.fromARGB(255, 240, 240, 240),
            contentPadding: EdgeInsets.only(left: 10),
            border: OutlineInputBorder(
                borderRadius: _borderRadius, borderSide: BorderSide.none),
            suffixIcon: IconButton(
              onPressed: () => setState(() => _obsecureText1 = !_obsecureText1),
              icon: _obsecureText1 ? Icon(Icons.alarm_off) : Icon(Icons.alarm),
              splashColor: Colors.transparent, //去掉点击阴影效果
              highlightColor: Colors.transparent, //去掉点击阴影效果
            )),
      ),
    );
  }

  //第二次输入新密码
  Widget _passwordNew2() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 25, right: 25),
      child: TextField(
        controller: pwdController2,
        onChanged: (text) => {_checkUserInput()},
        obscureText: _obsecureText2,
        decoration: InputDecoration(
            hintText: "请再次输入新密码",
            filled: true,
            fillColor: Color.fromARGB(255, 240, 240, 240),
            contentPadding: EdgeInsets.only(left: 10),
            border: OutlineInputBorder(
                borderRadius: _borderRadius, borderSide: BorderSide.none),
            suffixIcon: IconButton(
              onPressed: () => setState(() => _obsecureText2 = !_obsecureText2),
              icon: _obsecureText2 ? Icon(Icons.alarm_off) : Icon(Icons.alarm),
              splashColor: Colors.transparent, //去掉点击阴影效果
              highlightColor: Colors.transparent, //去掉点击阴影效果
            )),
      ),
    );
  }

  // 关闭按钮
  Widget _cancel() {
    // ignore: deprecated_member_use
    return FlatButton(
      color: Theme.of(context).primaryColor,
      child: Text(
        "关闭",
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  ///确认修改按钮
  _getConfirmButtonPressed() {
    if (!_isEnableLogin) return null;
    var oldPassword = pwdController.text,
        newPassword = pwdController1.text,
        newPassword1 = pwdController2.text;

    if (newPassword1 != newPassword) {
      return () {
        showDialog(
            context: this.context,
            builder: (context) {
              return AlertDialog(
                title: Text("修改信息"),
                content: Text("修改失败\n两次输入密码不一致"),
                actions: <Widget>[
                  _cancel(),
                ],
              );
            });
      };
    } else {
      if (oldPassword != Constant.password) {
        return () {
          showDialog(
              context: this.context,
              builder: (context) {
                return AlertDialog(
                  title: Text("修改信息"),
                  content: Text("修改失败\n原密码输入错误"),
                  actions: <Widget>[
                    _cancel(),
                  ],
                );
              });
        };
      } else {
        Constant.password = newPassword1;
        return () {
          showDialog(
              context: this.context,
              builder: (context) {
                return AlertDialog(
                  title: Text("修改信息"),
                  content: Text("修改成功\n"),
                  actions: <Widget>[
                    _cancel(),
                  ],
                );
              });
        };
      }
    }
  }

  /// 确认按钮
  Widget _buildButtonConfirm() {
    return Container(
        color: Theme.of(context).primaryColor,
        margin: EdgeInsets.only(top: 20, left: 25, right: 25),
        width: MediaQuery.of(context).size.width,
        height: 45,
        // ignore: deprecated_member_use
        child: MaterialButton(
          child: Text(
            "确认",
          ),
          color: Theme.of(context).primaryColor,
          disabledColor: Colors.black12,
          textColor: Colors.white,
          disabledTextColor: Colors.black12,
          shape: RoundedRectangleBorder(borderRadius: _borderRadius),
          onPressed: _getConfirmButtonPressed(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("修改密码"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              HeadUtil(),
              _passwordOld(),
              _passwordNew1(),
              _passwordNew2(),
              _buildButtonConfirm(),
            ],
          ),
        ),
      ),
    );
  }
}
