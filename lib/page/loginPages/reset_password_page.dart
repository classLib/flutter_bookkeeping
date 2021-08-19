import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/util/constants.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

/// 重置密码页面
class _ResetPasswordPageState extends State<ResetPasswordPage> {
  Size size;

  var _pwdTxt;
  var _secPwdTxt;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
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
      style: Constants.normalTextStyle,
    );
    var _passwordEdit = TextField(
      onChanged: (text) {
        _pwdTxt = text;
      },
      decoration: InputDecoration(
        hintText: '设置新密码',
        hintStyle: Constants.hintTextStyle,
        contentPadding: EdgeInsets.only(left: size.width * 0.05),
        border: UnderlineInputBorder(borderSide: BorderSide.none),
      ),
    );

    var _passwordSecondTitle = Text(
      '确认密码',
      style: Constants.normalTextStyle,
    );
    var _passwordSecondEdit = TextField(
      onChanged: (text) {
        _secPwdTxt = text;
      },
      decoration: InputDecoration(
        hintText: '再次输入新密码',
        hintStyle: Constants.hintTextStyle,
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    );

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            width: size.width * 1.0,
            height: size.height * 0.12,
            padding: EdgeInsets.only(left: size.width * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                title,
              ],
            ),
          ),
          Container(
            height: size.height * 0.02,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: size.width * 0.05),
            height: size.width * 0.10,
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
            height: size.height * 0.02,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: size.width * 0.05),
            height: size.width * 0.10,
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
            height: size.height * 0.05,
          ),
          Container(
            width: size.width * 0.9,
            height: size.width * 0.1,
            child: confirmBtn,
          ),
        ],
      ),
    );
  }

  void _confirmPassword() {}
}
