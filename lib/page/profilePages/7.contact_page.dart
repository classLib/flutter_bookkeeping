import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/page/profilePages/8.privacy_page.dart';
import 'package:flutter_bookkeeping/page/profilePages/9.join_us_page.dart';

/// FileName: 7.contact_page
/// Author: hjy
/// Date: 2021/8/10 22:15
/// Description:联系我们界面

class ContactPage extends StatefulWidget {
  const ContactPage({Key key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  var menuTitles = ["隐私政策", "加入我们"];

  onListTileTap(index) {
    if (index == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PrivacyPage()));
    }else{
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => JoinUsPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("联系我们"),
          backgroundColor: Theme.of(context).accentColor,
        ),
        body: ListView.separated(
          itemCount: menuTitles.length + 1, //共有len+1行
          separatorBuilder: (context, index) {
            return Divider();
          }, //分隔线
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Container(
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
                      Text("随手记账 1.0")
                    ],
                  ),
                ),
              );
            } else {
              return ListTile(
                title: Text(menuTitles[index - 1]), //title
                trailing: Icon(Icons.arrow_forward_ios), //右边
                onTap: () {
                  if (null != this.onListTileTap(index - 1))
                    this.onListTileTap(index - 1);
                },
              );
            }
            return Container();
          },
        ));
  }
}
