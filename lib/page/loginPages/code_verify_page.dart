import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/util/constant.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

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
  var _countdown = 60;
  var _currTime;
  var _code;

  var _btnEnable = false;
  var _waitText = '发送验证码';
  var _codeTxt;
  var _sendBtnColor = Colors.lightBlue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currTime = _countdown;
    _sendCode();
  }

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

  Widget _buildBodyWidget() {
    var title = Text(
      '输入短信验证码',
      style: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w500,
      ),
    );

    var titleTips = Text(
      '已向  ${widget._phoneNumber}  发送验证码',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    );

    var inputTitle = Text('验证码',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black));

    var codeInput = TextField(
      onChanged: (text) {
        _codeTxt = text;
      },
      minLines: 1,
      maxLines: 1,
      maxLength: 6,
      decoration: InputDecoration(
        hintText: '填写验证码',
        counterText: '',
        hintStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
        prefixStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        suffixIcon: IgnorePointer(
          ignoring: !_btnEnable,
          child: FlatButton(
            color: Colors.transparent,
            onPressed: _sendCode,
            child: Text(
              _waitText,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _sendBtnColor),
            ),
            shape: StadiumBorder(side: BorderSide.none),
          ),
        ),
        contentPadding: EdgeInsets.only(left: 20, top: 16, bottom: 16),
        border: UnderlineInputBorder(borderSide: BorderSide.none),
      ),
      keyboardType: TextInputType.number,
    );

    var submitBtn = FlatButton(
      color: Colors.lightBlue,
      onPressed: _submitCode,
      child: Text(
        '提交',
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    );

    return Container(
      margin:
          EdgeInsets.only(left: size.width * 0.06, right: size.width * 0.06),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: size.width * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                title,
                titleTips,
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.05),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.lightBlue))),
            child: Row(
              children: <Widget>[
                inputTitle,
                Expanded(child: codeInput),
              ],
            ),
          ),
          Container(
            width: size.width * 1.0,
            height: size.height * 0.07,
            margin: EdgeInsets.only(top: size.height * 0.06),
            child: submitBtn,
          ),
          Spacer(),
        ],
      ),
    );
  }

  /// 开始倒计时
  _startTimer() {
    _sendBtnColor = Colors.grey;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_currTime == 0) {
        _timer.cancel();
        setState(() {
          _waitText = '发送验证码';
          _currTime = _countdown;
          _sendBtnColor = Colors.lightBlue;
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
  _sendCode() async {
    setState(() {
      _code = _randomCode();
      _sendEmail(widget._phoneNumber, 'bookkeeping',
              '您的验证码为:${_code}，该验证码5分钟内有效，请勿泄漏于他人。')
          .then((value) {
        _btnEnable = false;
        _startTimer();
      });
    });
  }

  String _randomCode() {
    var code = '';
    for (int i = 0; i < 6; i++) {
      code += Random().nextInt(10).toString();
    }
    return code;
  }

  /// 提交验证码
  _submitCode() {
    if (_codeTxt == null || _codeTxt.isEmpty) {
      Fluttertoast.showToast(msg: '验证码不能为空');
      return null;
    }

    if (_codeTxt != _code) {
      Fluttertoast.showToast(msg: '验证码错误');
      _code = _randomCode();
      return;
    }

    /// 验证成功回到
    widget._callback();
  }

  _sendEmail(String toMailId, String title, String body) async {
    var username = '2447461103@qq.com';
    var password = Constant.email_code;
    final smtpServer = qq(username, password);
    final message = Message()
      ..from = Address(username, 'bookkeeping')
      ..recipients.add(toMailId)
      ..subject = title
      ..text = body;

    try {
      final sendReport = await send(message, smtpServer);
    } on MailerException catch (e) {
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
