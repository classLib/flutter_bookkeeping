//数据库存储类别的表
class  CategoryTable{

  static final String TABLE_NAME = "category_table";
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
    {'id': 3, 'image': 'assets/icon-test.png'},
    {'id': 4, 'image': 'assets/jiaotong.png'},
    {'id': 5, 'image': 'assets/lingshi_2.png'},
    {'id': 6, 'image': 'assets/canyin.png'},
    {'id': 7, 'image': 'assets/fushi-_1.png'},
    {'id': 8, 'image': 'assets/icon-test.png'},
    {'id': 9, 'image': 'assets/jiaotong.png'},
    {'id': 10, 'image': 'assets/lingshi_2.png'},
    {'id': 11, 'image': 'assets/fushi-_1.png'},
    {'id': 12, 'image': 'assets/fushi-_1.png'},
    {'id': 13, 'image': 'assets/icon-test.png'},
    {'id': 14, 'image': 'assets/jiaotong.png'},
    {'id': 15, 'image': 'assets/lingshi_2.png'},
    {'id': 16, 'image': 'assets/canyin.png'},
    {'id': 17, 'image': 'assets/fushi-_1.png'},
    {'id': 18, 'image': 'assets/icon-test.png'},
    {'id': 19, 'image': 'assets/jiaotong.png'},
    {'id': 20, 'image': 'assets/lingshi_2.png'},
  ];
}