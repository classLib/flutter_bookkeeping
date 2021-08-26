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
import 'package:flutter_bookkeeping/model/categorySetting/category.dart';
import 'package:flutter_bookkeeping/util/DbHelper.dart';

import '../../constantWr.dart';
import 'category_setting_main.dart';

class CategoryIncomeAdd extends StatefulWidget {
  final DbHelper categoryProvider = new DbHelper();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _CategoryIncomeAddState();
  }
}

class _CategoryIncomeAddState extends State<CategoryIncomeAdd> {
  // 默认的图片编号为1
  var curImageNum;
  var curImage;

  final _normalFont = const TextStyle(fontSize: 18.0);
  final _borderRadius = BorderRadius.circular(10);

  final _textController = TextEditingController();
  String text = '';

  List<Catetory> _historyWords = [];
//  初始化状态
  @override
  void initState() {
    super.initState();
    text = _textController.text;
    _getDataFromDb();
    _init();

  }

  _getDataFromDb () async {
    _historyWords = await widget.categoryProvider.queryAll();
    // await widget.categoryProvider.deleteAll();
    print(_historyWords.length);
  }
  _init() async {
    setState(() {
      curImageNum = 5;
      curImage = 'assets/qujianzhi.png';
    });
  }

  List<Widget> _listView(context) {
    List<Widget> listWidget = [];
    // 遍历全局图片组件生成对应的weight
    CategoryImageNum.incomeImageList.map((e) => {listWidget.add(listItem(e))}).toList();
    return listWidget;
  }

  Widget listItem(item) {
    return InkWell(
        onTap: () {
          setState(() {
            // 更新全局所选的id
            curImageNum = item['id'];
            curImage = item['image'];
          });

          print(item['id']);
          print(curImage);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            item['image'],
            width: 60,
            height: 60,
          ),
        ));
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
          title: Text('分类增加'),
          centerTitle: true,
          backgroundColor: Colors.blue),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 15, right: 15, top: 20),
        child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 500),
            child: Column(
              children: <Widget>[
                //输入框
                Container(height: 90, child: inputWidget()),
                ImageListWidget(context),
                _buildButton()
              ],
            )),
      ),
    );
  }

  // 图片输入框
  Widget inputWidget() {
    return Container(
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
        controller: _textController,
        style: TextStyle(fontSize: 20, color: Colors.black87), //文字大小、颜色
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            /*边角*/
            borderRadius: BorderRadius.all(
              Radius.circular(30), //边角为30
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
          labelText: "请输入分类名称",
          helperText: "请输入不超过三个字",
          helperStyle: TextStyle(color: Colors.red),
          prefixIconConstraints: BoxConstraints(
            //添加内部图标之后，图标和文字会有间距，实现这个方法，不用写任何参数即可解决
          ),
          prefixIcon: Image.asset(
            curImageNum == 5 ? 'assets/qujianzhi.png' : curImage,
            width: 40,
            height: 40,
          ),
        ),
      ),
    );
  }

  // 图片展示
  Widget ImageListWidget(context) {
    return Wrap(
      spacing: 4, //主轴上子控件的间距
      runSpacing: 5, //交叉轴上子控件之间的间距
      children: _listView(context), //要显示的子控件集合
    );
  }
  // 按钮提示
  Widget _buildButton() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      width: MediaQuery.of(context).size.width,
      height: 45,
      child: RaisedButton(
        child: Text("添加新标签", style: _normalFont),
        color: Colors.blue,
        disabledColor: Colors.black12,
        textColor: Colors.white,
        disabledTextColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: _borderRadius,
        ),
        onPressed:() {
          // _show(); // 提示不能成功
          _storeCatrgoty(_textController.text);

        },
      ),
    );
  }
  // 存储新的分类记录
  // 获取文本框的内容填充
  _storeCatrgoty (value) async {
    print(value);

    setState(()=>{
      text = _textController.text
    });
    _textController.clear(); // 清空文本框
    Catetory catetory = new Catetory(value,0,curImage);
    await widget.categoryProvider.insert(catetory).then((value) => setState(() => _historyWords.insert(0, value)));
    // 将history传给上一层
    Navigator.pop(context,_historyWords);

  }
  // 新增成功之后，弹出新增成功的模态框
  _show() {
    return () {
      showDialog(
          context: this.context,
          builder: (context) {
            return AlertDialog(
              title: Text("新增分类${text}成功"),
              actions: <Widget>[
                FlatButton(
                    color: Colors.blue,
                    child: Text(
                      '确认',
                      style: _normalFont,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryHomePage()));
                    }),
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Colors.blue,
                    child: Text(
                      '取消',
                      style: _normalFont,
                    )),
              ],
            );
          });
    };
  }

}
