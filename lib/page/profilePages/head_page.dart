/// FileName: bottom_sheet_widget
/// Author: hjy
/// Date: 2021/8/9 9:59
/// Description: 头像组件

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottom_sheet_widget.dart';

class HeadPage extends StatefulWidget {
  @override
  _HeadPageState createState() => _HeadPageState();
}

class _HeadPageState extends State<HeadPage> {
  var menuItems = ["拍照", "从图库中选择"];
  //拍照
  _takePhoto() {}
  //打开图库
  _openGallery() {}

  //点击头像
  onHeaderTap() {
    return showDialog(
      barrierDismissible: true, //是否点击空白区域关闭对话框,默认为true，可以关闭
      context: context,
      builder: (BuildContext context) {
        //底部导航栏
        return BottomSheetWidget(
          list: menuItems,
          onItemClickListener: (index) async {
            print(menuItems[index]);
            if (menuItems[index] == "拍照")
              _takePhoto();
            else
              _openGallery();
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 110.0,
        height: 110.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
            image: DecorationImage(
              image: AssetImage('assets/user.png'),
              fit: BoxFit.cover,
            )),
      ),
      onTap: () {
        if (null != onHeaderTap()) this.onHeaderTap();
      },
    );
  }
}
