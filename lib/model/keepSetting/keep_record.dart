import 'dart:ffi';

import 'package:flutter_bookkeeping/util/constant.dart';

/// FileName: keep_record
/// Author: hjy
/// Date: 2021/8/15 20:16
/// Description:

class KeepRecord {
  //id
  int id;

  String recordCategoryName;
  int recordCategoryNum;
  String recordImage;
  Double recordNumber;
  String recordRemarks;
  String recordTime;
  KeepRecord(this.id,
      {this.recordCategoryName,
      this.recordCategoryNum,
      this.recordTime,
      this.recordImage,
      this.recordRemarks,
      this.recordNumber});

  //  格式转换
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      KeepTable.recordRemarks: this.recordRemarks,
      KeepTable.recordImage: this.recordImage,
      KeepTable.recordTime: this.recordTime,
      KeepTable.recordCategoryNum: this.recordCategoryNum,
      KeepTable.recordCategoryName: this.recordCategoryName,
      KeepTable.recordNumber: this.recordNumber,
    };
    if (this.id != null) map[KeepTable.recordId] = this.id;
    return map;
  }

  static KeepRecord fromMap(Map<String, dynamic> map) =>
      KeepRecord(map[KeepTable.recordId],
          recordCategoryName: map[KeepTable.recordCategoryName],
          recordCategoryNum: map[KeepTable.recordCategoryNum],
          recordImage: map[KeepTable.recordImage],
          recordNumber: map[KeepTable.recordNumber],
          recordRemarks: map[KeepTable.recordRemarks],
          recordTime: map[KeepTable.recordTime]);
}
