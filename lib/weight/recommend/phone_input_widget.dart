import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bookkeeping/page/loginPages/code_verify_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 手机号输入
class PhoneInputWidget extends StatelessWidget {
  Size size;
  String _phoneNumber;
  Function _callback;

  PhoneInputWidget(this._callback);

  @override
  Widget build(BuildContext context) => _buildPhoneConfirmWidget(context);

  Widget _buildPhoneConfirmWidget(BuildContext context) {
    size = MediaQuery.of(context).size;

    var phoneEdit = TextField(
      onChanged: (text) {
        _phoneNumber = text;
      },
      style: TextStyle(fontSize: 21, letterSpacing: 1),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 27, top: 18, bottom: 18),
        hintText: '邮箱',
        hintStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.transparent)),
        filled: true,
        fillColor: Colors.white,
      ),
    );

    var loginBtn = FlatButton(
      color: Colors.lightBlue,
      onPressed: () {
        if (_phoneNumber == null || _phoneNumber.isEmpty) {
          Fluttertoast.showToast(msg: '邮箱为空或者格式错误');
          return null;
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CaptchaPage(_phoneNumber, this._callback)));
      },
      child: Text(
        '获取验证码',
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    );

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: phoneEdit,
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.04),
            width: MediaQuery.of(context).size.width * 1.0,
            height: MediaQuery.of(context).size.height * 0.07,
            child: loginBtn,
          ),
        ],
      ),
    );
  }
}
