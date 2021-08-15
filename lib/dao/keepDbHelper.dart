import 'package:flutter_bookkeeping/model/keepSetting/keep_record.dart';
import 'package:flutter_bookkeeping/util/DbHelper.dart';
import 'package:flutter_bookkeeping/util/constant.dart';

/// FileName: keepDbHelper
/// Author: hjy
/// Date: 2021/8/15 20:31
/// Description:

class KeepDbHelper {
  //新增
  static Future<KeepRecord> insert(KeepRecord record) async {
    var __db = await DbHelper.instance.db;
    try {
      record.id = await __db.insert(KeepTable.TABLE_NAME, record.toMap());
      print("id: ${record.id}");
    } catch (e) {
      print("error");
    }
    return record;
  }

//删
  static Future<KeepRecord> query(int id) async {
    var __db = await DbHelper.instance.db;
    List<Map> maps = await __db.query(KeepTable.TABLE_NAME,
        where: '${KeepTable.recordId} = ?', whereArgs: [id]);
    if (maps.length > 0) return KeepRecord.fromMap(maps.first);
    return null;
  }
//通过日期查询

// 删除全部
  static Future<int> deleteAll() async {
    var __db = await DbHelper.instance.db;

    return await __db.delete(KeepTable.TABLE_NAME);
  }

//通过id删除
  static Future<int> deleteById(int id) async {
    var __db = await DbHelper.instance.db;

    return await __db.delete(KeepTable.TABLE_NAME,
        where: '${KeepTable.recordId} = ?', whereArgs: [id]);
  }
}
