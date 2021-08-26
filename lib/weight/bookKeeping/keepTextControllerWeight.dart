// ignore: camel_case_types
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/page/bookKeeping/calculator.dart';

// ignore: must_be_immutable
class KeepTextControllerWeight extends StatefulWidget{

  TextEditingController keepTextController = TextEditingController();

  KeepTextControllerWeight(this.keepTextController);
  @override
  State<StatefulWidget> createState() {
    return new _KeepTextControllerWeightState(this.keepTextController);
  }

}
class _KeepTextControllerWeightState extends State<KeepTextControllerWeight> {
  TextEditingController keepTextController = TextEditingController();
  //  默认的一些配置
  final marginSetting = EdgeInsets.fromLTRB(0, 15, 0, 0);
  FocusNode _commentFocus = FocusNode();


  _KeepTextControllerWeightState(this.keepTextController) :super();


  @override
  Widget build(BuildContext context) {
    return Container(
            margin: marginSetting, //外边距，父容器本身相对外部容器的移动
            child: Container(
              height: 50,
              constraints: BoxConstraints(maxHeight: 56, minHeight: 56),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFE8E8E8),
                    width: 2,
                  ),
                ),
              ),
              child: TextField(
                controller: keepTextController,
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
                  labelText: "请输入钱数",
                  helperStyle: TextStyle(color: Colors.red),
                  prefixIconConstraints: BoxConstraints(),
                  prefixIcon: InkWell(
                    child: Container(
                      child: Image.asset(
                        'assets/licaitouzi.png',
                        width: 30,
                        height: 40,
                      ),
                    ),
                    onTap: () async {
                      showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Column(
                              children: [Expanded(child: Calculator(keepTextController))],
                            );
                          });
                      // final result = await Navigator.pushNamed(context);
                    },
                  ),
                ),
              ),
            ),
          );
  }

}
