// 分类新增   --收入子页面
// 所含部件
/**
 * 一个图标
 * 一个输入框
 * 图标组件，点击图标，可以实现更换
 * 一个按钮，点击这个按钮实现保存，弹出框保存成功
 * 返回在所有分类的页面可以看到
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryIncomeAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _CategoryIncomeAddState();
  }

}

class _CategoryIncomeAddState extends State<CategoryIncomeAdd> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        body: new Text('收入')
    );
  }

}