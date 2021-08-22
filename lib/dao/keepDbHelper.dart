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
      // print(record.toMap()[KeepTable.recordNumber]);  // 有数据的，
      record.id = await __db.insert(KeepTable.TABLE_NAME, record.toMap());
      print("新增记录成功 id: ${record.id}");
      if (record.recordNumber is String) {
        print('是string类型');
      } else if (record.recordNumber is double) {
        print('double');
      } else {
        print('其他类型');
      }
    } catch (e) {
      print("error");
    }
    return record;
  }

  // 查询全部
  static Future<List<KeepRecord>> queryAll() async {
    var _dbClient = await DbHelper.instance.db;
    List<Map<String, dynamic>> maps =
        await _dbClient.query(KeepTable.TABLE_NAME);
    List<KeepRecord> list = [];
    maps.forEach((value) {
      list.add(KeepRecord.fromMap(value));
      print('查询的记录钱数');
      print(value['recordCategoryName']);
    });
    return list;
  }

  //  通过id查询
  static Future<KeepRecord> query(int id) async {
    // 根据id查询成功
    var __db = await DbHelper.instance.db;
    List<Map> maps = await __db
        .query(KeepTable.TABLE_NAME, where: 'id = ?', whereArgs: [id]);
    if (maps.length > 0) {
      maps.forEach((value) {
        if (value['recordNumber'] is String) {
          print('string');
        } else {
          print('查询第一条的钱数是double');
        }
        print(value['recordCategoryName']);
      });
    }
    if (maps.length > 0) return KeepRecord.fromMap(maps.first);

    print("通过id查询成功");
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
    print('通过id删除成功');
    return await __db.delete(KeepTable.TABLE_NAME,
        where: '${KeepTable.recordId} = ?', whereArgs: [id]);
  }
}
