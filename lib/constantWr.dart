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