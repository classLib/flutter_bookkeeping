import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/util/constant.dart';

class ResetPasswordPage extends StatefulWidget {

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

/// 重置密码页面
class _ResetPasswordPageState extends State<ResetPasswordPage> {
  Size size;

  String _pwdTxt = '';
  String _secPwdTxt = '';

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 21,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _buildBodyWidget(),
    );
  }

  _buildBodyWidget() {
    var title = Text(
      '设置新密码',
      style: TextStyle(
        fontSize: 42,
        fontWeight: FontWeight.w500,
      ),
    );

    var _passwordTitle = Text(
      '新密码',
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
    );
    var _passwordEdit = TextField(
      onChanged: (text) {
        _pwdTxt = text;
      },
      decoration: InputDecoration(
        hintText: '设置新密码',
        hintStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
        contentPadding: EdgeInsets.only(left: size.width * 0.05),
        border: UnderlineInputBorder(borderSide: BorderSide.none),
      ),
    );

    var _passwordSecondTitle = Text(
      '确认密码',
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
    );
    var _passwordSecondEdit = TextField(
      onChanged: (text) {
        _secPwdTxt = text;
      },
      decoration: InputDecoration(
        hintText: '再次输入新密码',
        hintStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
        contentPadding: EdgeInsets.only(left: size.width * 0.05),
        border: UnderlineInputBorder(borderSide: BorderSide.none),
      ),
    );

    var confirmBtn = FlatButton(
      onPressed: _confirmPassword,
      child: Text(
        '确定',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
      ),
      color: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    );

    return Container(
      padding:
          EdgeInsets.only(left: size.width * 0.06, right: size.width * 0.06),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: size.height * 0.06),
            child: Column(
              children: <Widget>[
                title,
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.02),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.lightBlue))),
            child: Row(
              children: <Widget>[
                Container(
                  width: size.width * 0.15,
                  child: _passwordTitle,
                ),
                Expanded(child: _passwordEdit),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.02),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.lightBlue))),
            child: Row(
              children: <Widget>[
                Container(
                  width: size.width * 0.15,
                  child: _passwordSecondTitle,
                ),
                Expanded(child: _passwordSecondEdit),
              ],
            ),
          ),
          Container(
            width: size.width * 1.0,
            height: size.height * 0.07,
            margin: EdgeInsets.only(top: size.height * 0.06),
            child: confirmBtn,
          ),
          Spacer(),
        ],
      ),
    );
  }

  _confirmPassword() {
    if (_pwdTxt.isEmpty || _secPwdTxt.isEmpty) {
      return;
    }
    if (_pwdTxt != _secPwdTxt) {
      return;
    }
    Constant.password = _pwdTxt;

  }
}
