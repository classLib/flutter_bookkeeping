/// FileName: bottom_sheet_widget
/// Author: hjy
/// Date: 2021/8/9 9:59
/// Description: 头像组件

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'bottom_sheet_widget.dart';

class HeadPage extends StatefulWidget {
  @override
  _HeadPageState createState() => _HeadPageState();
}

class _HeadPageState extends State<HeadPage> {
  //实例化选择图片
  final ImagePicker picker = new ImagePicker();
  //用户本地图片
  File _userImage; //存放获取到的本地路径

  var menuItems = ["拍照", "从图库中选择"];
  //拍照
  _takePhoto() async {
    final cameraImages = await picker.getImage(source: ImageSource.camera);
    if (mounted) {
      setState(() {
        //拍摄照片不为空
        if (cameraImages != null) {
          _userImage = File(cameraImages.path);
          print('你选择的路径是：${_userImage.toString()}');
          //图片为空
        } else {
          print('没有照片可以选择');
        }
      });
    }
  }

  //打开图库
  _openGallery() async {
    //选择相册
    final pickerImages = await picker.getImage(source: ImageSource.gallery);
    if (mounted) {
      setState(() {
        if (pickerImages != null) {
          _userImage = File(pickerImages.path);
          print('你选择的本地路径是：${_userImage.toString()}');
        } else {
          print('没有照片可以选择');
        }
      });
    }
  }

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
            Navigator.pop(context);
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
              image:
                  // AssetImage("assets/user.png"),
                  _userImage == null
                      ? AssetImage("assets/user.png")
                      : Image.file(_userImage).image,
              fit: BoxFit.cover,
            )),
      ),
      onTap: () {
        if (null != onHeaderTap()) this.onHeaderTap();
      },
    );
  }
}
