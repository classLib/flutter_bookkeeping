//目录类
import '../constantWr.dart';

class Catetory {
//  类别id
  int id;

//  0 为收入， 1为支出
  int category_belong;

//  类别图片的编号
  int category_inmage_num;

//  类别名称
  String category_name;


  Catetory(this.id, {this.category_belong, this.category_inmage_num,this.category_name});
  //  格式转换
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      CategoryTable.CATEGORY_NAME: this.category_name,
      CategoryTable.CATEGORY_BELON:this.category_belong,
      CategoryTable.CATEGORY_IMAGE_NUM:this.category_inmage_num,
    };
    if (this.id != null) map[CategoryTable.CATEGORY_ID] = this.id;
    return map;
  }
  static Catetory fromMap(Map<String, dynamic> map) => Catetory(map[CategoryTable.CATEGORY_ID],
      category_belong : map[CategoryTable.CATEGORY_BELON],
      category_name : map[CategoryTable.CATEGORY_NAME],
      category_inmage_num: map[CategoryTable.CATEGORY_IMAGE_NUM]);

}
