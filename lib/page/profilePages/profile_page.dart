import 'package:flutter/material.dart';

void main() {
  runApp(Profile());
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  //点击事件
  onListTileTap() {}

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
            height: 210.0,
            color: Colors.red,
          );
        }

        return ListTile(
          leading: Icon(menuIcons[index - 1]), //左边
          title: Text(menuTitles[index - 1]), //title
          trailing: Icon(Icons.arrow_forward_ios), //右边
          onTap: onListTileTap(),
        );
      },
    ));
  }
}
