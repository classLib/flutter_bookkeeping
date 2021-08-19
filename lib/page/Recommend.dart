import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/model/book_model.dart';
import 'package:flutter_bookkeeping/model/course_model.dart';
import 'package:flutter_bookkeeping/model/official_account_model.dart';
import 'package:flutter_bookkeeping/model/tool_model.dart';
import 'package:flutter_bookkeeping/widgets/recommend/carousel_widget.dart';

class RecommendPage extends StatefulWidget {
  @override
  _RecommendPageState createState() => _RecommendPageState();
}

/// 推荐页面
class _RecommendPageState extends State<RecommendPage> {
  Size size;

  var _imgs;
  List<BookModel> _books;
  List<CourseModel> _courses;
  List<OfficialAccount> _officialAccounts;
  List<ToolModel> _tools;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshPage();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey[120],
      body: _buildBodyWidget(),
    );
  }

  _buildBodyWidget() {
    return RefreshIndicator(
      onRefresh: _refreshPage,
      child: ListView(
        children: <Widget>[
          _buildImgsCarouselWidget(),
          _buildSubfieldTitle('书籍推荐'),
          _buildBooksWidget(),
          _buildSubfieldTitle('优质课程'),
          _buildCourseWidget(),
          _buildSubfieldTitle('公众号'),
          _buildOfficialAccountWidget(),
          _buildSubfieldTitle('工具'),
          _buildToolsWidget(),
        ],
      ),
    );
  }

  /// 顶部轮播图
  _buildImgsCarouselWidget() {
    return Container(
      margin: EdgeInsets.all(10),
      width: size.width * 1.0,
      height: 180,
      child: CarouselWidget(_imgs),
    );
  }

  /// 分栏标题
  _buildSubfieldTitle(String title) {
    var titleTxt = Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );

    return Container(
      width: size.width * 0.8,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          titleTxt,
        ],
      ),
    );
  }

  _buildBooksWidget() {
    return Container(
      color: Colors.transparent,
      width: size.width * 1.0,
      height: 180,
      margin:
          EdgeInsets.only(left: size.width * 0.01, right: size.width * 0.01),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _books.length,
        itemBuilder: (context, index) {
          return _bookItem(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.transparent,
            width: size.width * 0.06,
          );
        },
      ),
    );
  }

  _buildCourseWidget() {
    return Container(
      color: Colors.transparent,
      width: size.width * 1.0,
      height: 160,
      margin:
          EdgeInsets.only(left: size.width * 0.01, right: size.width * 0.01),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _courses.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return _courseItem(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.transparent,
            width: size.width * 0.04,
          );
        },
      ),
    );
  }

  _buildOfficialAccountWidget() {
    return Container(
      color: Colors.transparent,
      width: size.width * 1.0,
      height: 160,
      margin:
          EdgeInsets.only(left: size.width * 0.01, right: size.width * 0.01),
      child: GridView.builder(
        padding: EdgeInsets.only(bottom: size.height * 0.03),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: size.width * 0.05,
            crossAxisSpacing: size.height * 0.01,
            childAspectRatio: 1 / 3),
        scrollDirection: Axis.horizontal,
        itemCount: _officialAccounts.length,
        itemBuilder: (context, index) {
          return _officialAccountItem(index);
        },
      ),
    );
  }

  _buildToolsWidget() {
    return Container(
      color: Colors.transparent,
      width: size.width * 1.0,
      height: 120,
      margin:
          EdgeInsets.only(left: size.width * 0.01, right: size.width * 0.01),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _tools.length,
        itemBuilder: (context, index) {
          return _toolItem(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.transparent,
            width: size.width * 0.05,
          );
        },
      ),
    );
  }

  _bookItem(int index) {
    var name = Text(
      _books[index].bookName,
      maxLines: 2,
      style: TextStyle(fontSize: 12),
    );
    var img = Image(
      image: _books[index].imgs[0],
      fit: BoxFit.cover,
    );

    return Container(
      width: size.width * 0.2,
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          Container(
            width: size.width * 0.2,
            height: 140,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: img,
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(child: name),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _courseItem(int index) {
    var img = Image(
      image: _courses[index].imgs[0],
      fit: BoxFit.cover,
    );
    var name = Text(
      _courses[index].name,
      style: TextStyle(fontSize: 12),
    );
    var publisher = Text(
      _courses[index].publisher,
      style: TextStyle(fontSize: 12),
    );
    var icon = Icon(
      Icons.person,
      size: 16,
    );
    var stuCount = Text(_courses[index].stuCount.toString());

    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.30,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: img,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        name,
                        publisher,
                      ],
                    ),
                  ),
                  Container(
                      child: Row(
                    children: <Widget>[
                      icon,
                      stuCount,
                    ],
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _officialAccountItem(int index) {
    var name = Text(_officialAccounts[index].name);
    var img = Image(
      image: _officialAccounts[index].imgs[0],
      fit: BoxFit.cover,
      width: 45,
      height: 45,
    );

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipOval(
                child: img,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    name,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _toolItem(int index) {
    var name = Text(_tools[index].name);
    var img = Image(
      image: _tools[index].imgs[0],
      fit: BoxFit.cover,
      width: 60,
      height: 60,
    );

    return Container(
      child: Column(
        children: <Widget>[
          InkWell(
            splashColor: Colors.transparent,
            onTap: () {},
            child: ClipOval(
              child: img,
            ),
          ),
          name,
        ],
      ),
    );
  }

  /// 界面刷新
  Future<void> _refreshPage() async {
    setState(() {
      _books = <BookModel>[];
      _courses = <CourseModel>[];
      _officialAccounts = <OfficialAccount>[];
      _tools = <ToolModel>[];
      _imgs = <dynamic>[];

      /// 轮播图
      for (int i = 0; i < 3; i++) {
        _imgs.add(AssetImage('wangyiyouqian/images/recommend/000${i}.jpg'));
      }

      _getBooksInfo();
      _getCourceInfo();
      _getOfficialAccountInfo();
      _getToolsInfo();
    });
  }

  _getBooksInfo() {
    /// 书籍
    var authors = [
      '本杰明·格雷厄姆 / Benjamin Graham',
      '李笑来',
      '[美] 霍华德·马克斯 Howard Marks',
      '邱国鹭',
      'T. 哈维‧艾克',
      ' 曾琬鈴',
      ' [美] 埃德温·勒菲弗',
      '[英] 亚当·图兹',
      '阿比吉特•班纳吉 (Abhijit V.Banerjee) / 埃斯特•迪弗洛 (Esther Duflo)',
      '李杰',
    ];

    var times = [
      '2020-8',
      '2017-8',
      '2012-7',
      '2014-10',
      '2017-6',
      '2016-12',
      '2010-11',
      '2021-6',
      '2013-4',
      '2014-3',
    ];

    var booksName = [
      '聪明的投资者',
      '财富自由之路',
      '投资最重要的事',
      '投资中最简单的事',
      '有钱人和你想的不一样',
      '不上班也有錢',
      '股票大作手回忆录',
      '崩盘',
      '贫穷的本质',
      '股市进阶之道',
    ];

    var bookIndexs = _getRandomList(5, 10);
    for (int i = 0; i < bookIndexs.length; i++) {
      _books.add(BookModel(
        authorFigure: AssetImage('wangyiyouqian/images/3.0x/bg_theme_0.png'),
        author: authors[bookIndexs[i]],
        time: times[bookIndexs[i]],
        bookName: booksName[bookIndexs[i]],
        imgs: [
          AssetImage('wangyiyouqian/images/recommend/00${bookIndexs[i]}0.jpg'),
        ],
        fabulous: Random().nextInt(1000),
        collections: Random().nextInt(1000),
        comments: Random().nextInt(1000),
      ));
    }
  }

  List<int> _getCourceInfo() {
    var coursesName = [
      '聪明的投资者',
      '财商逆袭人生',
      '巴菲特的投资智慧',
      '懒人理财',
      '公司理财',
      '我为什么要学理财'
    ];
    var publishers = [
      '玖算教育',
      '亿启教育',
      '玖算教育',
      '亿启教育',
      '常道教育',
      '财多多教育',
    ];
    var courseIndexs = _getRandomList(5, 6);
    for (int i = 0; i < courseIndexs.length; i++) {
      _courses.add(CourseModel(
        name: coursesName[courseIndexs[i]],
        imgs: [
          AssetImage(
              'wangyiyouqian/images/recommend/20${courseIndexs[i]}0.jpg'),
        ],
        publisher: publishers[courseIndexs[i]],
        stuCount: Random().nextInt(1000),
      ));
    }
  }

  _getOfficialAccountInfo() {
    var name = ['简七理财', '招财大牛猫', '小基快跑', '基金豆', '老钱说钱', '复利先生'];
    var courseIndexs = _getRandomList(6, 6);
    for (int i = 0; i < courseIndexs.length; i++) {
      _officialAccounts.add(OfficialAccount(
        name: name[courseIndexs[i]],
        imgs: [
          AssetImage(
              'wangyiyouqian/images/recommend/300${courseIndexs[i]}.jpg'),
        ],
      ));
    }
  }

  _getToolsInfo() {
    var name = [
      '知乎',
      '腾讯课堂',
    ];
    var toolIndexs = _getRandomList(2, 2);
    for (int i = 0; i < toolIndexs.length; i++) {
      _tools.add(ToolModel(
        name: name[toolIndexs[i]],
        imgs: [
          AssetImage('wangyiyouqian/images/recommend/400${toolIndexs[i]}.jpg'),
        ],
      ));
    }
  }

  List<int> _getRandomList(var maxCount, var maxRange) {
    List<int> resultList = [];
    var rng = new Random();
    int count = 0;
    while (count < maxCount) {
      //生成6个
      int index = rng.nextInt(maxRange); // 1-12之间区间
      if (!resultList.contains(index)) {
        resultList.add(index);
        count++;
      }
    }
    return resultList;
  }
}
