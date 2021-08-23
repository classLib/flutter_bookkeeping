//目录类

import '../../constantWr.dart';

class Catetory {
//  类别id
  int id;

//  类别名称
  String category_name;

//  0 为收入， 1为支出
  int category_belong;

//  类别图片路径
  String category_inmage_num;

  Catetory(this.category_name, this.category_belong, this.category_inmage_num,
      {this.id});
  //  格式转换
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      CategoryTable.CATEGORY_NAME: this.category_name,
      CategoryTable.CATEGORY_BELON: this.category_belong,
      CategoryTable.CATEGORY_IMAGE_NUM: this.category_inmage_num,
    };
    if (this.id != null) map[CategoryTable.CATEGORY_ID] = this.id;
    return map;
  }

  // 必须的就不用 category_name:
  static Catetory fromMap(Map<String, dynamic> map) => Catetory(
      map[CategoryTable.CATEGORY_NAME],
      map[CategoryTable.CATEGORY_BELON],
      map[CategoryTable.CATEGORY_IMAGE_NUM],
      id: map[CategoryTable.CATEGORY_ID]);
  // static Catetory
}
