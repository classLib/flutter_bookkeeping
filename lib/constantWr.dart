//数据库存储类别的表
import 'dart:ui';

import 'package:flutter/material.dart';

import 'model/categorySetting/category.dart';

class CategoryTable {
  // ignore: non_constant_identifier_names
  static final String TABLE_NAME = "category_administration_table";

//  类别编号
  static final String CATEGORY_ID = "id";

//  类别名称
  static final String CATEGORY_NAME = "category_name";

//  0 为收入， 1为支出
  static final String CATEGORY_BELON = "category_belong";

//  类别图片的编号
  static final String CATEGORY_IMAGE_NUM = "category_inmage_num";
}

class DbConstant {
  static final String dbName = "bookkeeping.db";
  static final int dbVersion = 1;
}

class CategoryImageNum {
  // 通过分类名称对应图片编号
  static final List expenditureIamgeList = [
    {'id': 1, 'image': 'assets/canyin.png'},
    {'id': 2, 'image': 'assets/fushi-_1.png'},
    {'id': 3, 'image': 'assets/yundong_1.png'},
    {'id': 4, 'image': 'assets/jiaotong.png'},
    {'id': 5, 'image': 'assets/lingshi_2.png'},
    {'id': 6, 'image': 'assets/-fen-.png'},
    {'id': 7, 'image': 'assets/amusement-park-svgrepo-com.png'},
    {'id': 8, 'image': 'assets/huazhuang_3.png'},
    {'id': 9, 'image': 'assets/chongwumaomi.png'},
    {'id': 10, 'image': 'assets/icon-test.png'},
    {'id': 11, 'image': 'assets/liwu.png'},
    {'id': 12, 'image': 'assets/lvhang_1.png'},
    {'id': 13, 'image': 'assets/qita_1.png'},
    {'id': 14, 'image': 'assets/riyongpin.png'},
    {'id': 15, 'image': 'assets/shuiguo_3.png'},
    {'id': 16, 'image': 'assets/shuji.png'},
    {'id': 17, 'image': 'assets/tongxunlu_4.png'},
    {'id': 18, 'image': 'assets/tubiaozhizuomoban.png'},
    {'id': 19, 'image': 'assets/wodexuexi.png'},
  ];
  static final List incomeImageList = [
    {'id': 1, 'image': 'assets/-changbei.png'},
    {'id': 2, 'image': 'assets/bangong.png'},
    {'id': 3, 'image': 'assets/hongbao_1.png'},
    {'id': 4, 'image': 'assets/qita_1.png'},
    {'id': 5, 'image': 'assets/qujianzhi.png'},
    {'id': 6, 'image': 'assets/salary.png'},
    {'id': 7, 'image': 'assets/zijinlicai.png'},
  ];
}

//默认的类别图片

class CategoryImage  {
    static final List<Catetory> expenditureCategory = [
      Catetory('餐饮',1,'assets/canyin.png'),
      Catetory('服饰',1,'assets/fushi-_1.png'),
      Catetory('运动',1,'assets/yundong_1.png'),
      Catetory('交通',1,'assets/jiaotong.png'),
      Catetory('零食',1,'assets/lingshi_2.png'),
      Catetory('生活用品',1,'assets/riyongpin.png'),
      Catetory('化妆品',1,'assets/huazhuang_3.png'),
      Catetory('宠物',1,'assets/chongwumaomi.png'),
      Catetory('礼物',1,'assets/liwu.png'),
      Catetory('旅行',1,'assets/lvhang_1.png'),
      Catetory('水果',1,'assets/shuiguo_3.png'),
      Catetory('学习',1,'assets/shuji.png'),
      Catetory('其他',1,'assets/qita_1.png'),
    ];
    static final List<Catetory> inComeCategory = [
      Catetory('父母',0,'assets/-changbei.png'),
      Catetory('兼职',0,'assets/qujianzhi.png'),
      Catetory('红包',0,'assets/hongbao_1.png'),
      Catetory('工资',0,'assets/salary.png'),
      Catetory('理财',0,'assets/zijinlicai.png'),
      Catetory('其他',0,'assets/qita_1.png'),
    ];
}


//默认按键
class keyBoardList {
//输入按钮
  static final color = Color(0xFF363636);
  static final keyColorBefore = Color(0xFFE89E28);
  static final keyColorAfter = Color(0xFFEDC68F);
  static final List<Map> keyboardList = [
    {'text': '7', 'color': color},
    {'text': '8', 'color': color},
    {'text': '9', 'color': color},
    {
      'text': '删除',
      'textColor': Colors.black,
      'color': Color(0xFFA5A5A5),
      'highlightColor': Color(0xFFD8D8D8)
    },
    {'text': '4', 'color': color},
    {'text': '5', 'color': color},
    {'text': '6', 'color': color},
    {
      'text': '-',
      'color': keyColorBefore,
      'highlightColor': keyColorAfter
    },
    {'text': '1', 'color': color},
    {'text': '2', 'color': color},
    {'text': '3', 'color': color},
    {
      'text': '+',
      'color': keyColorBefore,
      'highlightColor': keyColorAfter
    },
    {'text': '0', 'color': color, 'width': 158.0},
    {'text': 'AC', 'color': color},
    {
      'text': '=',
      'color': keyColorBefore,
      'highlightColor': keyColorAfter
    },
  ];
}
