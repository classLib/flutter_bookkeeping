
import 'package:flutter_bookkeeping/util/constant.dart';

/// FileName: keep_record
/// Author: hjy
/// Date: 2021/8/15 20:16
/// Description:

class KeepRecord {
  //id
  int id;
  // 记录分类名称
  String recordCategoryName;
  // 记录类型
  int recordCategoryNum;
  // 记录的图片
  String recordImage;
  // 记录的钱数
  double recordNumber;
  // 记录的备注
  String recordRemarks;
  // 记录创建的时间
  String recordTime;

  KeepRecord(this.recordCategoryName, this.recordCategoryNum, this.recordTime,
      this.recordImage, this.recordRemarks, this.recordNumber,
      {this.id});

  //  格式转换
  static KeepRecord fromMap(Map<String, dynamic> map) => KeepRecord(
      map[KeepTable.recordCategoryName],
      map[KeepTable.recordCategoryNum],
      map[KeepTable.recordTime],
      map[KeepTable.recordImage],
      map[KeepTable.recordRemarks],
      map[KeepTable.recordNumber],
      id: map[KeepTable.recordId]
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      KeepTable.recordCategoryName: this.recordCategoryName,

      KeepTable.recordCategoryNum: this.recordCategoryNum,
      KeepTable.recordTime:
      this.recordTime ?? DateTime.now().millisecondsSinceEpoch,
      KeepTable.recordImage: this.recordImage,
      KeepTable.recordRemarks:this.recordRemarks,
      KeepTable.recordNumber:this.recordNumber,
    };
    if (this.id != null) map[KeepTable.recordId] = this.id;
    return map;
  }
}
