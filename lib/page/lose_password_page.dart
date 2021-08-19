import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/page/reset_password_page.dart';
import 'package:flutter_bookkeeping/widgets/phone_input_widget.dart';

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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.blue,
          ),
        ),
      ),
      body: _buildBodyWidget(),
    );
  }

  _buildBodyWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: size.width * 1.0,
            height: size.height * 0.16,
            padding: EdgeInsets.only(left: size.width * 0.06),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '获取验证码',
                  style: TextStyle(fontSize: 32),
                ),
              ],
            ),
          ),
          PhoneInputWidget(() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ResetPasswordPage()));
          }),
        ],
      ),
    );
  }
}
