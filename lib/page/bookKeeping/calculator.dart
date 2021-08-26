import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constantWr.dart';

// typedef onSubmittedCallback = void Function(String value);

class Calculator extends StatefulWidget {
  TextEditingController keepTextController = TextEditingController();

  Calculator(this.keepTextController);

  // 支持回调
  // final onSubmittedCallback onCollback;
  // Calculator(this.onCollback);
  /*路由别名*/
  static const routeName = '/calculator';

  @override
  State<StatefulWidget> createState() {
    return new _CalculatorState(this.keepTextController);
  }
}

class _CalculatorState extends State<Calculator> {
  TextEditingController keepTextController = TextEditingController();

  _CalculatorState(this.keepTextController) : super();

  // 文本
  String _text = '';

  // 点击事件的回调函数

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: Container(
            child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  '$_text',
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            _CalculatorKeyboard(
              onValueChange: _onValueChange,
            ),
            SizedBox(
              height: 50,
            ),
            // 按钮保存
            // ignore: deprecated_member_use
            RaisedButton(
                child: Text('保存'),
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                onPressed: () {
                  // 传值到上一个页面
                  keepTextController.text = _text;
                  Navigator.of(context).pop(_text);
                })
          ],
        )),
      ),
    );
  }

//  点击之后的回调函数
  void _onValueChange(String value) {
    switch (value) {
      // 清空
      case 'AC':
        setState(() {
          _text = '0';
        });
        break;
      case '+':
      case '-':
        setState(() {
          _text += value;
        });

        break;
      case '0':
      case '1':
      case '2':
      case '3':
      case '4':
      case '5':
      case '6':
      case '7':
      case '8':
      case '9':
        setState(() {
          // 去掉第一个字符
          if (_text.startsWith('0')) {
            _text = _text.substring(1);
          }
          _text += value;
        });

        break;
      case '删除':
        int size = _text.length;
        setState(() {
          _text = _text.substring(0, size - 1);
        });

        break;

      case '=':
        setState(() {
          // 处理所有的结果
          _text = _value2Double(_text).toString();
        });
        break;
    }
  }

  int _value2Double(String exp) {
    // 处理加减
    // 先截取字符串
    int res = 0;
    // 获取最开始的两个，进行计算
    String sign = exp.substring(0, 1);
    String tmp = "+";
    if (sign != '-') {
      exp = tmp + exp;
    }
    // 找到所有的加号
    RegExp mobile = new RegExp("\\+[0-9]+");
    Iterable<Match> mobiles = mobile.allMatches(exp);
    for (Match m in mobiles) {
      String match = m.group(0);
      res = res + int.parse(m.group(0).substring(1, m.group(0).length));
      print(match);
      print(res);
    }
    RegExp mobileSub = new RegExp("\\-[0-9]+");
    Iterable<Match> mobileSubs = mobileSub.allMatches(exp);
    for (Match m in mobileSubs) {
      String match = m.group(0);
      res = res - int.parse(m.group(0).substring(1, m.group(0).length));
      print(match);
      print(res);
    }
    return res;
  }
}

//按钮组件
class _CalculatorItem extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color color;
  final Color highlightColor;
  final double width;

  // 点击事件的回调函数
  final ValueChanged<String> onValueChange;

  _CalculatorItem(
      {this.text,
      this.textColor,
      this.color,
      this.highlightColor,
      this.width,
      this.onValueChange});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.all(Radius.circular(200))),
      child: InkWell(
        onTap: () {
          onValueChange('$text');
        },
        borderRadius: BorderRadius.all(Radius.circular(200)),
        highlightColor: highlightColor ?? color,
        child: Container(
          width: width ?? 70,
          height: 70,
          padding: EdgeInsets.only(left: width == null ? 0 : 25),
          alignment: width == null ? Alignment.center : Alignment.centerLeft,
          child: Text(
            '$text',
            style: TextStyle(color: textColor ?? Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }
}

//输入按钮组件
class _CalculatorKeyboard extends StatelessWidget {
  final ValueChanged<String> onValueChange;

  const _CalculatorKeyboard({Key key, this.onValueChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 18,
      spacing: 18,
      children: List.generate(keyBoardList.keyboardList.length, (index) {
        return _CalculatorItem(
          text: keyBoardList.keyboardList[index]['text'],
          textColor: keyBoardList.keyboardList[index]['textColor'],
          color: keyBoardList.keyboardList[index]['color'],
          highlightColor: keyBoardList.keyboardList[index]['highlightColor'],
          width: keyBoardList.keyboardList[index]['width'],
          onValueChange: onValueChange,
        );
      }),
    );
  }
}
