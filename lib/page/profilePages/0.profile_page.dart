/// FileName: bottom_sheet_widget
/// Author: hjy
/// Date: 2021/8/9 9:59
/// Description:我的页面

import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/page/profilePages/6.bookkeeping_reminder_page.dart';
import 'package:flutter_bookkeeping/page/profilePages/head_widget.dart';
import 'package:flutter_bookkeeping/page/profilePages/5.password_page.dart';
import 'package:flutter_bookkeeping/page/profilePages/3.theme_page.dart';
import 'package:flutter_bookkeeping/page/profilePages/4.username_page.dart';
import 'package:flutter_bookkeeping/util/constant.dart';

import '7.contact_page.dart';

void main() {
  runApp(Profile());
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blueGrey),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool backUp = false;
  bool init = false;

  //标题
  List menuTitles = ['备份和同步', '账本初始化', '主题切换', '修改用户名', '修改密码', '记账提醒', '联系我们'];
  //图标
  List menuIcons = [
    Icons.message,
    Icons.print,
    Icons.error,
    Icons.phone,
    Icons.send,
    Icons.people,
    Icons.person,
    Icons.phone,
  ];

  //点击备份和同步
  onBackUp() {}

  //点击账本初始化
  onInitBook() {}
  //点击页面列表
  onListTileTap(index) {
    if (index == 0) {
    } else if (index == 1) {
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ThemePage(),
        ),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UsernamePage(),
        ),
      );
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PasswordPage(),
        ),
      );
    } else if (index == 5) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookKeepingReminderPage(),
        ),
      );
    } else if (index == 6) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ContactPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: menuTitles.length + 2, //共有len+1行
        separatorBuilder: (context, index) {
          return Divider();
        }, //分隔线
        itemBuilder: (BuildContext context, int index) {
          //头像处
          if (index == 0) {
            return Container(
              color: Theme.of(context).primaryColor,
              height: 200.0,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, //头像居中
                  children: <Widget>[
                    HeadPage(),
                    SizedBox(
                      //加间距
                      height: 10.0,
                    ),
                    Text(
                      '点击切换头像',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            );
          }
          //备份和同步
          else if (index == 1) {
            return ListTile(
              leading: Icon(menuIcons[index - 1]), //左边
              title: Text(menuTitles[index - 1]), //title
              trailing: Switch(
                value: this.backUp,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (value) {
                  setState(() {
                    this.backUp = value;
                    onBackUp();
                  });
                },
              ),
            );
          }
          //账本初始化
          else if (index == 2) {
            return ListTile(
              leading: Icon(menuIcons[index - 1]), //左边
              title: Text(menuTitles[index - 1]), //title
              trailing: Switch(
                value: this.init,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (value) {
                  setState(() {
                    this.init = value;
                    onInitBook();
                  });
                },
              ),
            );
          }
          //退出登录
          else if (index == menuTitles.length + 1) {
            return Container(
                color: Theme.of(context).accentColor,
                margin: EdgeInsets.only(top: 20, left: 25, right: 25),
                width: MediaQuery.of(context).size.width,
                height: 45,
                // ignore: deprecated_member_use
                child: new MaterialButton(
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white,
                  child: new Text('退出登录'),
                  onPressed: () {
                    print("111");
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                ));
          }
          //列表项
          else {
            return ListTile(
              leading: Icon(menuIcons[index - 1]), //左边
              title: Text(menuTitles[index - 1]), //title
              trailing: Icon(Icons.arrow_forward_ios), //右边
              onTap: () {
                if (null != this.onListTileTap(index - 1))
                  this.onListTileTap(index - 1);
              },
            );
          }
        },
      ),
    );
  }
}
