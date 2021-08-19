import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/util/constants.dart';

/// 验证码验证页面
class CaptchaPage extends StatefulWidget {
  String _phoneNumber;
  Function _callback;

  CaptchaPage(this._phoneNumber, this._callback);

  @override
  _CaptchaPageState createState() => _CaptchaPageState();
}

class _CaptchaPageState extends State<CaptchaPage> {
  Size size;

  var _timer;

  /// 计时器
  var _countdown = 60;

  /// 重新发送验证码倒计时
  var _currTime;

  /// 当前时间

  var _btnEnable = false;
  var _waitText = '发送验证码';
  var _btnColor = Colors.blue;
  var _codeText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currTime = _countdown;

    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
          suffixIcon: IgnorePointer(
            ignoring: !_btnEnable,
            child: FlatButton(
              color: _btnColor,
              onPressed: _sendCode,
              child: Text(
                _waitText,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              shape: StadiumBorder(side: BorderSide(color: Colors.blue)),
            ),
          ),
          contentPadding: EdgeInsets.all(size.width * 0.03),
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
            width: size.width * 1.0,
            height: size.height * 0.15,
            margin: EdgeInsets.only(bottom: size.height * 0.02),
            padding: EdgeInsets.only(left: size.width * 0.02),
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
            color: Colors.white,
            width: size.width * 1.0,
            margin: EdgeInsets.only(bottom: size.height * 0.05),
            padding: EdgeInsets.only(
              left: size.width * 0.02,
              right: size.width * 0.02,
            ),
            child: Row(
              children: <Widget>[
                inputTitle,
                Expanded(child: codeInput),
              ],
            ),
          ),
          Container(
            width: size.width * 0.95,
            height: size.height * 0.07,
            child: submitBtn,
          ),
        ],
      ),
    );
  }

  /// 开始倒计时
  _startTimer() {
    _btnColor = Colors.grey;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_currTime == 0) {
        _timer.cancel();
        setState(() {
          _btnColor = Colors.blue;
          _waitText = '发送验证码';
          _currTime = _countdown;
          _btnEnable = true;
        });
        return;
      }
      _currTime--;
      setState(() {
        _waitText = '重新发送(' + _currTime.toString() + ')';
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  /// 发送验证码
  _sendCode() {
    setState(() {
      _btnEnable = false;
      _startTimer();
    });
  }

  /// 提交验证码
  void _submitCode() {
    if (_codeText.isEmpty) return null;

    /// 验证信息

    /// 验证成功回到
    widget._callback();
  }
}
