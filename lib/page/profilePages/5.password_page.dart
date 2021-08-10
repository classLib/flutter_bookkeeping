import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/util/constant.dart';

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
  bool _obsecureText = true;

  ///border
  final _borderRadius = BorderRadius.circular(6);
  //控制密码的输入，获取其内容
  final pwdController = TextEditingController();
  //获取，将数据持久化到磁盘中
  // Future<SharedPreferences> _pres = SharedPreferences.getInstance();

  Widget _passwordOld() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 25, right: 25),
      child: TextField(
        controller: pwdController,
        onChanged: (text) => {},
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("修改密码"),
        backgroundColor: themeColorMap[Constant.key_theme_color],
      ),
      body: Container(
        child: Column(
          children: [
            _passwordOld(),
          ],
        ),
      ),
    );
  }
}
