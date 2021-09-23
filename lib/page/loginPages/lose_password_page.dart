import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/page/loginPages/reset_password_page.dart';
import 'package:flutter_bookkeeping/util/head_util.dart';
import 'package:flutter_bookkeeping/weight/recommend/phone_input_widget.dart';

class LosePasswordPage extends StatefulWidget {
  @override
  _LosePasswordPageState createState() => _LosePasswordPageState();
}

/// 忘记密码页面
class _LosePasswordPageState extends State<LosePasswordPage> {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 21,
          ),
        ),
      ),
      body: _buildBodyWidget(),
    );
  }

  _buildBodyWidget() {
    return Container(
      margin:
          EdgeInsets.only(left: size.width * 0.06, right: size.width * 0.06),
      child: Column(
        children: <Widget>[
          Container(
            width: size.width * 1.0,
            height: size.height * 0.16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '获取验证码',
                  style: TextStyle(fontSize: 36),
                ),
              ],
            ),
          ),
          Container(
            child: PhoneInputWidget(() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ResetPasswordPage()));
            }),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
