/// FileName: theme_page
/// Author: hjy
/// Date: 2021/8/9 21:12
/// Description: 主题切换界面

import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/util/constant.dart';
import 'package:flutter_bookkeeping/util/sp_helper.dart';
import 'package:provider/provider.dart';

import 'app_info.dart';

class ThemePage extends StatefulWidget {
  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  String _colorKey;

  @override
  void initState() {
    super.initState();

    _initAsync();
  }

  _initAsync() async {
    setState(() {
      _colorKey =
          SpHelper.getString(Constant.key_theme_color, defValue: 'blue');
    });
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
        backgroundColor: themeColorMap[_colorKey],
      ),
      body: ListView(
        children: <Widget>[
          ExpansionTile(
            leading: Icon(Icons.color_lens),
            title: Text('主题'),
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
                        setState(() {
                          _colorKey = key;
                        });
                        Constant.key_theme_color = key;
                        SpHelper.putString(Constant.key_theme_color, key);
                        Provider.of<AppInfoProvider>(context, listen: false)
                            .setTheme(key);
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
          // ListTile(
          //   leading: Icon(Icons.language),
          //   title: Text('多语言'),
          //   trailing: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: <Widget>[
          //       Text('跟随系统',
          //           style: TextStyle(
          //             fontSize: 14.0,
          //             color: Colors.grey,
          //           )),
          //       Icon(Icons.keyboard_arrow_right)
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
