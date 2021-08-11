import 'dart:async';
import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/model/book_model.dart';
import 'package:flutter_bookkeeping/model/course_model.dart';
import 'package:flutter_bookkeeping/model/official_account_model.dart';
import 'package:flutter_bookkeeping/model/tool_model.dart';
import 'package:flutter_bookkeeping/util/constants.dart';

class RecommendPage extends StatefulWidget {
  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {
  var _books;
  var _courses;
  var _officialAccounts;
  var _tools;

  var _timer;
  var _countdown;
  var _currTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _countdown = 10 * 60;
    _currTime = _countdown;
    _refreshPage();
    _startTimer();
  }

  Future<void> _refreshPage() async {
    setState(() {
      _books = <BookModel>[];
      _courses = <CourseModel>[];
      _officialAccounts = <OfficialAccount>[];
      _tools = <ToolModel>[];
      for (int i = 0; i < 30; i++) {
        _books.add(BookModel(WordPair.random().asString,
            'wangyiyouqian/images/3.0x/bg_theme_0.png'));
        _courses.add(CourseModel(
            WordPair.random().asString,
            'wangyiyouqian/images/3.0x/bg_theme_0.png',
            WordPair.random().asString,
            Random().nextInt(1000)));
        _officialAccounts.add(OfficialAccount(WordPair.random().asString,
            'wangyiyouqian/images/3.0x/bg_theme_0.png'));
        _tools.add(ToolModel(WordPair.random().asString,
            'wangyiyouqian/images/3.0x/bg_theme_0.png'));
      }
    });
  }

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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
      onRefresh: _refreshPage,
      child: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 1.0,
            height: MediaQuery.of(context).size.height * 1.0,
            child: Scaffold(
              backgroundColor: Colors.grey[300],
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Text(
                  '推荐',
                  style: Constants.normalTextStyle,
                ),
              ),
              body: _buildBodyWidget(),
            ),
          )
        ],
      ),
    );
  }

  _buildSubfieldTitle(String title) {
    var bookTitle = Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );

    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.06,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          bookTitle,
        ],
      ),
    );
  }

  _buildBodyWidget() {
    var countdownTips = Text('距离下次更新还有' + _currTime.toString() + '...');

    return Container(
      child: Column(
        children: <Widget>[
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

  _buildBooksWidget() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 1.0,
      height: MediaQuery.of(context).size.height * 0.21,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _books.length,
        shrinkWrap: false,
        itemBuilder: (context, index) {
          return _bookItem(index);
        },
      ),
    );
  }

  _buildCourseWidget() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 1.0,
      height: MediaQuery.of(context).size.height * 0.21,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _courses.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return _courseItem(index);
        },
      ),
    );
  }

  _buildOfficialAccountWidget() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 1.0,
      height: MediaQuery.of(context).size.height * 0.12,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _officialAccounts.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return _officialAccountItem(index);
        },
      ),
    );
  }

  _buildToolsWidget() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 1.0,
      height: MediaQuery.of(context).size.height * 0.12,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _tools.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return _toolItem(index);
        },
      ),
    );
  }

  _bookItem(int index) {
    var name = Text(_books[index].name);
    var img = Image(image: AssetImage(_books[index].img));

    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      child: GestureDetector(
        child: Column(
          children: <Widget>[
            name,
            Expanded(
              child: img,
            ),
          ],
        ),
      ),
    );
  }

  _courseItem(int index) {
    var img = Image(image: AssetImage(_books[index].img));
    var name = Text(_courses[index].name);
    var publisher = Text(_courses[index].publisher);
    var icon = Icon(Icons.person);
    var stuCount = Text(_courses[index].stuCount.toString());

    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      child: GestureDetector(
        child: Column(
          children: <Widget>[
            Expanded(
              child: img,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
    );
  }

  _officialAccountItem(int index) {
    var name = Text(_officialAccounts[index].name);
    var img = Image(image: AssetImage(_officialAccounts[index].img));

    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      child: GestureDetector(
        child: Column(
          children: <Widget>[
            Expanded(
              child: img,
            ),
            name,
          ],
        ),
      ),
    );
  }

  _toolItem(int index) {
    var name = Text(_officialAccounts[index].name);
    var img = Image(image: AssetImage(_officialAccounts[index].img));

    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      child: GestureDetector(
        child: Column(
          children: <Widget>[
            Expanded(
              child: img,
            ),
            name,
          ],
        ),
      ),
    );
  }
}
