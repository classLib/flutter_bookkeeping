import 'dart:async';
import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/model/book_model.dart';
import 'package:flutter_bookkeeping/model/course_model.dart';
import 'package:flutter_bookkeeping/model/official_account_model.dart';
import 'package:flutter_bookkeeping/model/tool_model.dart';
import 'package:flutter_bookkeeping/widgets/carousel_widget.dart';

class RecommendPage extends StatefulWidget {
  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {
  Size size;

  List<BookModel> _books;
  var _courses;
  var _officialAccounts;
  var _tools;
  var _imgs;

  var _timer;
  var _countdown;
  var _currTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _countdown = 10 * 60;
    _currTime = _countdown / 60;
    _refreshPage();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: _buildBodyWidget(),
    );
  }

  _buildBodyWidget() {
    var countdownTips = Text('距离下次更新还有' + _currTime.toString() + '分钟...');
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
      margin: EdgeInsets.all(size.width * 0.02),
      width: size.width * 1.0,
      height: size.height * 0.2,
      child: Card(
        color: Colors.black,
        elevation: 0,
        child: CarouselWidget(_imgs),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
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
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.04,
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
      width: MediaQuery.of(context).size.width * 1.0,
      height: MediaQuery.of(context).size.height * 0.2,
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
            width: MediaQuery.of(context).size.width * 0.06,
          );
        },
      ),
    );
  }

  _buildCourseWidget() {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width * 1.0,
      height: MediaQuery.of(context).size.height * 0.21,
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
            width: MediaQuery.of(context).size.width * 0.04,
          );
        },
      ),
    );
  }

  _buildOfficialAccountWidget() {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width * 1.0,
      height: MediaQuery.of(context).size.height * 0.2,
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
      width: MediaQuery.of(context).size.width * 1.0,
      height: MediaQuery.of(context).size.height * 0.08,
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
            width: size.width * 0.02,
          );
        },
      ),
    );
  }

  _bookItem(int index) {
    var name = Text(_books[index].bookName);
    var img = Image(
      image: _books[index].imgs[0],
      fit: BoxFit.fill,
    );

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        child: Column(
          children: <Widget>[
            Expanded(child: img),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[name],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _courseItem(int index) {
    var img = Image(
      image: AssetImage(_courses[index].img),
      fit: BoxFit.cover,
    );
    var name = Text(_courses[index].name);
    var publisher = Text(_courses[index].publisher);
    var icon = Icon(Icons.person);
    var stuCount = Text(_courses[index].stuCount.toString());

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.30,
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        child: InkWell(
          child: Column(
            children: <Widget>[
              Expanded(
                child: img,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
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
      ),
    );
  }

  _officialAccountItem(int index) {
    var name = Text(_officialAccounts[index].name);
    var img = Image(
      image: AssetImage(_officialAccounts[index].img),
      fit: BoxFit.cover,
    );

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Container(
        height: size.height * 0.06,
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: img,
              ),
              Expanded(
                child: name,
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
      image: AssetImage(_tools[index].img),
      fit: BoxFit.cover,
    );

    return Container(
      width: size.width * 0.15,
      child: Column(
        children: <Widget>[
          InkWell(
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
      for (int i = 0; i < 14; i++) {
        _books.add(BookModel(
            AssetImage('wangyiyouqian/images/3.0x/bg_theme_0.png'),
            'aa',
            '1-1',
            WordPair.random().asString,
            [
              AssetImage('wangyiyouqian/images/3.0x/bg_theme_0.png'),
            ],
            111,
            11,
            ['qq', '21']));
        _courses.add(CourseModel(
            WordPair.random().asString,
            'wangyiyouqian/images/3.0x/bg_theme_0.png',
            WordPair.random().asString,
            Random().nextInt(1000)));
        _officialAccounts.add(OfficialAccount(WordPair.random().asString,
            'wangyiyouqian/images/3.0x/bg_theme_0.png'));
        _tools.add(ToolModel(WordPair.random().asString,
            'wangyiyouqian/images/3.0x/bg_theme_0.png'));
        _imgs.add(AssetImage('wangyiyouqian/images/3.0x/bg_theme_0.png'));
      }
    });
  }

  /// 计时器开始
  _startTimer() {
    _timer = Timer.periodic(
      Duration(minutes: _countdown),
      (timer) {
        if (_currTime == 0) {
          _timer.cancel();
          _currTime = _countdown;
          _refreshPage();
          _startTimer();
          return;
        }
        if (_currTime % 60 == 0) {
          setState(() {});
        }
        _currTime--;
      },
    );
  }
}
