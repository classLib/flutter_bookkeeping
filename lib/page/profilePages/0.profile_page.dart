/// FileName: bottom_sheet_widget
/// Author: hjy
/// Date: 2021/8/9 9:59
/// Description:我的页面

import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/dao/keepDbHelper.dart';
import 'package:flutter_bookkeeping/model/keepSetting/keep_record.dart';
import 'package:flutter_bookkeeping/util/DbHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mysql1/mysql1.dart' as mysql;
import 'package:flutter_bookkeeping/page/loginPages/login_page.dart';
import 'package:flutter_bookkeeping/page/profilePages/6.bookkeeping_reminder_page.dart';
import 'package:flutter_bookkeeping/page/profilePages/head_widget.dart';
import 'package:flutter_bookkeeping/page/profilePages/5.password_page.dart';
import 'package:flutter_bookkeeping/page/profilePages/3.theme_page.dart';
import 'package:flutter_bookkeeping/page/profilePages/4.username_page.dart';
import 'package:flutter_bookkeeping/util/constant.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '7.contact_page.dart';

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
  var _prefs = SharedPreferences.getInstance();
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool backUp = false;
  bool init = false;
  MySqlConnection conn; //数据库链接
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
                  onPressed: () async {
                    var pref = await widget._prefs;
                    pref.setBool(Constant.is_login, false);

                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
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

  /// 如果sqlite数据库里面有东西，则同步到远端，若没有，则拉下来
  databaseConnect() async {
    var __db = await DbHelper.instance.db;
    List<Map> maps = await __db.query(KeepTable.TABLE_NAME);
    print('配置数据库链接');
    var s = ConnectionSettings(
      user: "root", //todo:用户名
      password: "123456", //todo:密码
      host: "47.94.45.181", //todo:flutter中电脑本地的ip
      port: 3306, //todo:端口
      db: "flutter_app", //todo:需要连接的数据库
    );
    //链接数据库
    await MySqlConnection.connect(s).then((_) {
      conn = _;
      print('连接成功');
    });
    if (maps.length > 0) {
      //  向远端同步，新增数据
      push();
    } else {
      // 向本地拉
      pull();
    }
  }

  push() async {
    var sql = "select id,record_number from keep_table where id=(select max(id) from keep_table)";
    var results = await conn.query(sql, []);
    var curId;
    for(var result in results) curId=result.fields["id"];
    var keepList = KeepDbHelper.queryAll();
    keepList.then((data) {
      data.forEach((element) {
        conn.query(
            'insert into keep_table (id,record_number,record_category_name,record_category_num,record_time,image_num,record_remarks) values (?,?,?,?,?,?,?)',
            [
              element.id + curId,
              element.recordNumber,
              element.recordCategoryName,
              element.recordCategoryNum,
              element.recordTime,
              element.recordImage,
              element.recordRemarks
            ]);
        print("同步成功");
      });
    });
  }

  pull() async {
    var results = await conn.query('select * from keep_table', []);
    for (var result in results) {
      KeepDbHelper.insert(KeepRecord.fromMap(result.fields));
    }
    print("备份成功");
  }

  //点击备份和同步
  onBackUp() {
    databaseConnect();
  }

  //点击账本初始化
  onInitBook() {
    if (this.init == true) {
      KeepDbHelper.deleteAll();
    }
  }

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
}
