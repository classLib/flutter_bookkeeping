import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/page/loginPages/lose_password_page.dart';
import 'package:flutter_bookkeeping/util/constants.dart';
import 'package:flutter_bookkeeping/widgets/recommend/phone_input_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  var _prefs = SharedPreferences.getInstance();

  _LoginPageState createState() => _LoginPageState();
}

enum LoginMode {
  AccountPassword,
  PhoneCode,
}

class _LoginPageState extends State<LoginPage> {
  Size size;
  var _loginMode;

  var _isEnableLogin;

  var _accountController;
  var _passwordController;
  var _accountText;
  var _passwordText;
  var _obscureText;

  var _clauseToggleValue;

  @override
  void initState() {
    // TODO: implement initState
    _loginMode = LoginMode.AccountPassword;
    _isEnableLogin = false;

    _accountController = TextEditingController();
    _passwordController = TextEditingController();

    _fillAccountTextField();

    _obscureText = true;
    _clauseToggleValue = false;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    var actionStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

    var noSecretBtn = FlatButton(
      onPressed: _loginByNoSecret,
      child: _loginMode == LoginMode.AccountPassword
          ? Text(
              '免密登录',
              style: actionStyle,
            )
          : Text(
              '密码登录',
              style: actionStyle,
            ),
      padding: EdgeInsets.only(
          left: size.width * 0.05,
          right: size.width * 0.05),
      color: Colors.white,
      splashColor: Colors.transparent,
      shape: StadiumBorder(side: BorderSide(color: Colors.transparent)),
    );

    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
        fontSize: 42,
        fontWeight: FontWeight.w500,
      ),
    );

    var accountEdit = TextField(
      onChanged: (text) {
        _accountText = text;
        _checkUserInput();
      },
      controller: _accountController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20),
        hintText: '手机号',
        hintStyle: Constants.hintTextStyle,
        border: Constants.editBorder,
        filled: true,
        fillColor: Colors.grey[300],
      ),
    );

    var passwordEdit = TextField(
      onChanged: (text) {
        _accountText = text;
        _checkUserInput();
      },
      controller: _passwordController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20),
        hintText: '密码',
        hintStyle: Constants.hintTextStyle,
        border: Constants.editBorder,
        filled: true,
        fillColor: Colors.grey[300],
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
      color: Colors.blue,
      onPressed: _loginListener,
      child: Text(
        '登录',
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    );

    var forgetPasswordBtn = FlatButton(
      onPressed: _forgetPassword,
      child: Text(
        '忘记密码',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blue),
      ),
      splashColor: Colors.transparent,
      shape: StadiumBorder(side: BorderSide(color: Colors.transparent)),
    );

    // var clauseToggle = Checkbox(
    //   value: _clauseToggleValue,
    //   onChanged: (value) {
    //     setState(() {
    //       _clauseToggleValue = value;
    //     });
    //   },
    // );

    return Container(
      width: size.width * 1.0,
      height: size.height * 1.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin:
                EdgeInsets.only(left: size.width * 0.1),
            width: size.width * 0.9,
            height: size.height * 0.1,
            child: Row(
              children: <Widget>[
                title,
              ],
            ),
          ),
          Container(
            margin:
                EdgeInsets.only(top: size.height * 0.1),
            width: size.width * 0.8,
            child: accountEdit,
          ),
          Container(
            margin:
                EdgeInsets.only(top: size.height * 0.04),
            width: size.width * 0.8,
            child: passwordEdit,
          ),
          Container(
            margin:
                EdgeInsets.only(top: size.height * 0.08),
            width: size.width * 0.8,
            height: size.height * 0.07,
            child: loginBtn,
          ),
          Container(
            margin:
                EdgeInsets.only(top: size.height * 0.08),
            width: size.width * 0.2,
            height: size.height * 0.07,
            child: forgetPasswordBtn,
          ),
          Spacer(),
          // Container(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       clauseToggle,
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildPhoneWidget() {
    var title = Text(
      '手机号登录',
      style: TextStyle(fontSize: 42, fontWeight: FontWeight.w500),
    );

    var titleTips = Text(
      '登录即注册',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    );

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin:
                EdgeInsets.only(left: size.width * 0.1),
            width: size.width * 0.9,
            height: size.height * 0.15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                title,
                titleTips,
              ],
            ),
          ),
          PhoneInputWidget(() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => null));
          }),
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
    if (!_isEnableLogin) return null;

    /// 记住密码时保存到本地缓存
    final SharedPreferences prefs = await widget._prefs;
    prefs.setString(Constants.user_account, _accountText);
    prefs.setString(Constants.user_password, _passwordText);

    /// 连接服务器，验证账号密码

    var pref = await widget._prefs;
    pref.setBool(Constants.is_login, true);

    /// 跳转到主界面
    Navigator.push(context, MaterialPageRoute(builder: (context) => null));
  }

  _forgetPassword() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LosePasswordPage()));
  }

  /// 填充缓存账号密码
  _fillAccountTextField() {
    widget._prefs.then((prefs) => {
          _accountController.text =
              prefs.getString(Constants.user_account) ?? '',
          _passwordController.text =
              prefs.getString(Constants.user_password) ?? '',
        });
  }

  /// 检查账号密码输入
  _checkUserInput() {
    if (_accountText.isNotEmpty && _passwordText.isNotEmpty) {
      if (_isEnableLogin) return;
    } else {
      if (!_isEnableLogin) return;
    }

    setState(() {
      _isEnableLogin = !_isEnableLogin;
    });
  }
}
