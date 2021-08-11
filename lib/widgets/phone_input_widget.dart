import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bookkeeping/page/code_verify_page.dart';
import 'package:flutter_bookkeeping/util/constants.dart';

class PhoneInputWidget extends StatelessWidget {
  String _phoneNumber;
  Function _callback;

  PhoneInputWidget(this._callback);

  @override
  Widget build(BuildContext context) => _buildPhoneConfirmWidget(context);

  Widget _buildPhoneConfirmWidget(BuildContext context) {
    var phoneEdit = TextField(
      onChanged: (text) {
        _phoneNumber = text;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20),
        hintText: '手机号',
        hintStyle: Constants.hintTextStyle,
        border: Constants.editBorder,
        filled: true,
        fillColor: Colors.grey[300],
      ),
      keyboardType: TextInputType.number,
    );

    var loginBtn = FlatButton(
      onPressed: () {
        if(_phoneNumber.isEmpty && _phoneNumber.length == 11) return null;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CodeVerifyPage(_phoneNumber, this._callback)));
      },
      child: Text(
        '获取验证码',
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: Colors.blue,
    );

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            width: MediaQuery.of(context).size.width * 0.8,
            child: phoneEdit,
          ),
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.07,
            child: loginBtn,
          ),
        ],
      ),
    );
  }
}
