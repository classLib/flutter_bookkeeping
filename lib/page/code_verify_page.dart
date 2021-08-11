import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/util/constants.dart';

class CodeVerifyPage extends StatefulWidget {
  var _phoneNumber;
  Function _callback;

  CodeVerifyPage(this._phoneNumber, this._callback);

  @override
  _CodeVerifyPageState createState() => _CodeVerifyPageState();
}

class _CodeVerifyPageState extends State<CodeVerifyPage> {
  var _isSuccessful;
  var _timer;
  var _countdown;
  var _currTime;

  var _waitText;
  var _waitStyle;

  var _codeText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isSuccessful = false;
    _countdown = 10;
    _currTime = _countdown;
    _waitText = '';
    _waitStyle = Colors.blue;

    _isSuccessful = false;

    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
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

  Widget _buildBodyWidget() {
    var title = Text(
      '输入短信验证码',
      style: TextStyle(
        fontSize: 42,
        fontWeight: FontWeight.w500,
      ),
    );

    var titleTips = Text(
      '已向  ${widget._phoneNumber}  发送验证码',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    );

    var inputTitle = Text('验证码', style: Constants.normalTextStyle);

    var codeInput = TextField(
      onChanged: (text) {
        _codeText = text;
      },
      decoration: InputDecoration(
          hintText: '填写验证码',
          hintStyle: Constants.hintTextStyle,
          prefixStyle: Constants.normalTextStyle,
          suffixIcon: FlatButton(
            color: _waitStyle,
            onPressed: () {
              setState(() {
                _startTimer();
              });
            },
            child: Text(
              _waitText,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            shape: StadiumBorder(side: BorderSide(color: Colors.blue)),
          ),
          contentPadding:
              EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
          border: UnderlineInputBorder(borderSide: BorderSide.none)),
    );

    var submitBtn = FlatButton(
      color: Colors.blue,
      onPressed: _submitCode,
      child: Text(
        '提交',
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    );

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width * 1.0,
            height: MediaQuery.of(context).size.height * 0.15,
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                title,
                titleTips,
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width * 1.0,
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.02,
              right: MediaQuery.of(context).size.width * 0.02,
            ),
            child: Row(
              children: <Widget>[
                inputTitle,
                Expanded(child: codeInput),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.07,
            child: submitBtn,
          ),
        ],
      ),
    );
  }

  /// 开始倒计时
  _startTimer() {
    _sendCode();
    _waitStyle = Colors.grey;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_currTime == 0) {
        _timer.cancel();
        setState(() {
          _waitStyle = Colors.blue;
          _waitText = '发送验证码';
          _currTime = _countdown;
        });
        return;
      }
      _currTime--;
      setState(() {
        _waitText = '重新发送(' + _currTime.toString() + ')';
      });
    });
  }

  /// 发送验证码
  _sendCode() {}

  /// 提交验证码
  void _submitCode() {
    if (_codeText.isEmpty) return null;

    /// 验证信息

    /// 验证成功回到
    widget._callback();
  }
}
