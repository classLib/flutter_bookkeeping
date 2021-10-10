import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// FileName: 9.join_us_page
/// Author: hjy
/// Date: 2021/8/10 22:36
/// Description:加入我们

class JoinUsPage extends StatefulWidget {
  const JoinUsPage({Key key}) : super(key: key);

  @override
  _JoinUsPageState createState() => _JoinUsPageState();
}

class _JoinUsPageState extends State<JoinUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("加入我们"),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: ListView(
          children: [
            Container(
              color: Theme.of(context).accentColor,
              height: 200.0,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, //头像居中
                  children: <Widget>[
                    Container(
                      width: 110.0,
                      height: 110.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                          image: DecorationImage(
                            image: AssetImage("assets/logo.png"),
                            fit: BoxFit.cover,
                          )),
                    ),
                    SizedBox(
                      height: 10.0, //加间距
                    ),
                    Text("大学生可视化记账分析 2.0")
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text("电话：15883529063"),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text("邮箱：965068089@qq.com"),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text("地址：四川省***市"),
            )
          ],
        ));
  }
}
