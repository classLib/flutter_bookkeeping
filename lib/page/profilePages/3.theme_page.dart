/// FileName: theme_page
/// Author: hjy
/// Date: 2021/8/9 21:12
/// Description: 主题切换界面

import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/util/constant.dart';
import 'package:flutter_bookkeeping/util/head_util.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/app_info.dart';

class ThemePage extends StatefulWidget {
  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  //获取，将数据持久化到磁盘中
  Future<SharedPreferences> _pres = SharedPreferences.getInstance();
  String _colorKey;

  _onTap(key) async{
    setState(() {
      _colorKey = key;
    });
    final SharedPreferences pres = await _pres;
    pres.setString(Constant.keyThemeColor, key);
    Provider.of<AppInfoProvider>(context, listen: false).setTheme(key);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('主题切换'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        children: <Widget>[
          HeadUtil(),
          ExpansionTile(
            leading: Icon(Icons.color_lens),
            title: Text('主题修改'),
            initiallyExpanded: true,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: themeColorMap.keys.map((key) {
                    Color value = themeColorMap[key];
                    return InkWell(
                      onTap: () {
                        _onTap(key);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        color: value,
                        child: _colorKey == key
                            ? Icon(
                                Icons.done,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
