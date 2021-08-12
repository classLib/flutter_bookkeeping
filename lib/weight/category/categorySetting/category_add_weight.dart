//分类页面下边的weight 就一个按钮


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef AddButtonCallback = void Function(CategoryAddWeight widget);
typedef DeleteWidgetCallback = void Function(CategoryAddWeight widget);

class CategoryAddWeight extends StatefulWidget {
  final String title;
  final int belong;

  final AddButtonCallback addButtonCallback;

  CategoryAddWeight({Key key, this.title, this.addButtonCallback,this.belong}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    _CategoryAddWeightState(this.title,this.belong);
  }

  
}

class _CategoryAddWeightState extends State<CategoryAddWeight> {
  final String title;
  final int belong;

  _CategoryAddWeightState(this.title, this.belong);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          // 点击按钮去
          widget.addButtonCallback(widget);
        }
      ),
    );
  }

}