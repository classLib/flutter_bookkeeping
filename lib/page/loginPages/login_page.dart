import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/page/loginPages/lose_password_page.dart';
import 'package:flutter_bookkeeping/util/constant.dart';
import 'package:flutter_bookkeeping/util/navigator_util.dart';
import 'package:flutter_bookkeeping/weight/recommend/phone_input_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoginMode {
  AccountPassword,
  PhoneCode,
}

class LoginPage extends StatefulWidget {
  var _prefs = SharedPreferences.getInstance();

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Size size;
  var _loginMode = LoginMode.AccountPassword;
  var _isEnableLogin = false;
  //输入框
  var _accountController = TextEditingController();
  var _passwordController = TextEditingController();
  //文本内容
  var _accountTxt = '';
  var _passwordTxt = '';
  var _obscureText = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget._prefs.then((pref) {
      if (pref.containsKey(Constant.is_login)) {
        if (pref.getBool(Constant.is_login) == true) {
          _intoIndexPage();
        } else {
          _fillAccountTextField();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    var noSecretBtn = FlatButton(
      onPressed: _loginByNoSecret,
      child: Text(
        _loginMode == LoginMode.AccountPassword ? '免密登录' : '密码登录',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
      ),
      padding:
          EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05),
      splashColor: Colors.transparent,
      shape: StadiumBorder(side: BorderSide(color: Colors.transparent)),
    );

    var close_btn = IconButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => IndexPage()));
      },
      icon: Icon(Icons.arrow_back_ios),
      color: Colors.white,
      iconSize: 21,
    );

    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        leading: close_btn,
        actions: <Widget>[
          noSecretBtn,
        ],
      ),
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    switch (_loginMode) {
      case LoginMode.AccountPassword:
        return _buildAccountWidget();
        break;
      case LoginMode.PhoneCode:
        return _buildPhoneWidget();
        break;
    }
  }

  Widget _buildAccountWidget() {
    var title = Text(
      '密码登录',
      style: TextStyle(
          fontSize: 36, fontWeight: FontWeight.w500, color: Colors.black),
    );

    var accountEdit = TextField(
      onChanged: (text) {
        _accountTxt = text;
        _checkUserInput();
      },
      controller: _accountController,
      style: TextStyle(fontSize: 21, letterSpacing: 1),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 27, top: 18, bottom: 18),
        hintText: '账号',
        hintStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.white)),
        filled: true,
        fillColor: Colors.white,
      ),
    );

    var passwordEdit = TextField(
      onChanged: (text) {
        _passwordTxt = text;
        _checkUserInput();
      },
      controller: _passwordController,
      style: TextStyle(fontSize: 21, letterSpacing: 1),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 27, top: 18, bottom: 18),
        hintText: '密码',
        hintStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.transparent)),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: IconButton(
            padding: EdgeInsets.only(left: 20, right: 20),
            icon: _obscureText == true
                ? Icon(Icons.visibility_outlined)
                : Icon(Icons.visibility_off_outlined),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            }),
      ),
      obscureText: _obscureText,
    );

    var loginBtn = FlatButton(
      color: Colors.lightBlue,
      onPressed: _loginListener,
      child: Text(
        '登录',
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: Colors.blue)),
    );

    var forgetPasswordBtn = FlatButton(
      onPressed: _forgetPassword,
      child: Text(
        '忘记密码',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.lightBlue),
      ),
      shape: StadiumBorder(side: BorderSide.none),
    );

    return Container(
      margin:
          EdgeInsets.only(left: size.width * 0.06, right: size.width * 0.06),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: size.height * 0.05),
            child: Row(
              children: <Widget>[
                title,
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.1),
            child: accountEdit,
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.02),
            child: passwordEdit,
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.05),
            width: size.width * 1.0,
            height: size.height * 0.07,
            child: loginBtn,
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.05),
            height: size.height * 0.06,
            child: forgetPasswordBtn,
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget _buildPhoneWidget() {
    var title = Text(
      '邮箱登录',
      style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
    );

    var titleTips = Text(
      '登录即注册',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    );

    return Container(
      margin:
          EdgeInsets.only(left: size.width * 0.06, right: size.width * 0.06),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: size.height * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                title,
                titleTips,
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.12),
            child: PhoneInputWidget(() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => IndexPage()));
            }),
          ),
          Spacer(),
        ],
      ),
    );
  }

  _loginByNoSecret() {
    setState(() {
      _loginMode = _loginMode == LoginMode.AccountPassword
          ? LoginMode.PhoneCode
          : LoginMode.AccountPassword;
    });
  }

  _loginListener() async {
    if (!_isEnableLogin) {
      Fluttertoast.showToast(msg: '账号密码不能为空');
      return;
    }
    if (_accountTxt != Constant.username || _passwordTxt != Constant.password) {
      Fluttertoast.showToast(msg: '账号密码错误，请重试');
      return;
    }

    /// 保存账号密码到本地缓存
    var prefs = await widget._prefs;
    prefs.setString(Constant.key_account, _accountTxt);
    prefs.setString(Constant.key_password, _passwordTxt);
    prefs.setBool(Constant.is_login, true);

    _intoIndexPage();
  }

  _intoIndexPage() {
    /// 跳转到主界面
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => IndexPage()));
  }

  _forgetPassword() {
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LosePasswordPage()));
  }

  /// 检查账号密码输入
  _checkUserInput() {
    if (_accountTxt.isNotEmpty && _passwordTxt.isNotEmpty) {
      if (_isEnableLogin) return;
    } else {
      if (!_isEnableLogin) return;
    }

    setState(() {
      _isEnableLogin = !_isEnableLogin;
    });
  }

  /// 填充缓存账号密码
  _fillAccountTextField() {
    widget._prefs.then((prefs) {
      setState(() {
        _accountController.text = prefs.getString(Constant.key_account) ?? '';
        _passwordController.text = prefs.getString(Constant.key_password) ?? '';
        _accountTxt = _accountController.text;
        _passwordTxt = _passwordController.text;
        _checkUserInput();
      });
    });
  }
}
