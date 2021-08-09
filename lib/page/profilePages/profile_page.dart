/// FileName: bottom_sheet_widget
/// Author: hjy
/// Date: 2021/8/9 9:59
/// Description:我的页面

import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/page/profilePages/head_page.dart';

void main() {
  runApp(Profile());
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List menuTitles = [
    '备份和同步',
    '账本初始化',
    '主题切换',
    '黄',
    '密码',
    '王阿姨',
    '记账提醒',
    '联系我们'
  ];
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
  //点击页面列表
  onListTileTap(index) {
    print("点击listTile$index");
  }



  //点击切换头像
  onHeaderTap() {



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.separated(
      itemCount: menuTitles.length + 1, //共有len+1行
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
                    '点击头像登录',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          );
        }
        //列表项
        else
          return ListTile(
            leading: Icon(menuIcons[index - 1]), //左边
            title: Text(menuTitles[index - 1]), //title
            trailing: Icon(Icons.arrow_forward_ios), //右边
            onTap: () {
              if (null != this.onListTileTap(index - 1))
                this.onListTileTap(index - 1);
            },
          );
      },
    ));
  }
}
