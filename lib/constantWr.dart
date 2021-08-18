//数据库存储类别的表
class  CategoryTable{

  static final String TABLE_NAME = "category_administration_table";
//  类别编号
  static final String CATEGORY_ID= "id";
//  类别名称
  static final String CATEGORY_NAME = "category_name";
//  0 为收入， 1为支出
  static final String CATEGORY_BELON= "category_belong";
//  类别图片的编号
  static final String CATEGORY_IMAGE_NUM= "category_inmage_num";
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