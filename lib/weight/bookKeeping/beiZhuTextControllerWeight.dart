import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BeiZhuTextControllerWeight extends StatefulWidget{

  TextEditingController beizhuTextController = TextEditingController();

  BeiZhuTextControllerWeight(this.beizhuTextController);
  @override
  State<StatefulWidget> createState() {
     return new _BeiZhuTextControllerWeightState(this.beizhuTextController);
  }

}
class _BeiZhuTextControllerWeightState extends State<BeiZhuTextControllerWeight> {
  TextEditingController beizhuTextController = TextEditingController();

  _BeiZhuTextControllerWeightState(this.beizhuTextController) :super();


  @override
  Widget build(BuildContext context) {
        return Container(
      margin: EdgeInsets.fromLTRB(0, 25, 0, 0), //外边距，父容器本身相对外部容器的移动
      child: Container(
        height: 50,
        constraints: BoxConstraints(maxHeight: 56, minHeight: 56),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFE8E8E8),
              width: 1,
            ),
          ),
        ),
        child: TextField(
          controller: beizhuTextController,
          style: TextStyle(fontSize: 15, color: Colors.black87), //文字大小、颜色
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              /*边角*/
              borderRadius: BorderRadius.all(
                Radius.circular(20), //边角为30
              ),
              borderSide: BorderSide(
                color: Colors.blue, //边线颜色为黄色
                width: 2, //边线宽度为2
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.lightBlue, //边框颜色为绿色
              width: 2, //宽度为5
            )),
            labelText: "写点备注吧",
            helperStyle: TextStyle(color: Colors.red),
            prefixIconConstraints: BoxConstraints(
                //添加内部图标之后，图标和文字会有间距，实现这个方法，不用写任何参数即可解决
                ),
            prefixIcon: Image.asset(
              // 'assets/beizhu_1.png' ,
              'assets/beizhu_1.png',
              width: 30,
              height: 30,
            ),
          ),
        ),
      ),
    );
  }

}

