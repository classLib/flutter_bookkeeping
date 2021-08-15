// 基于单例模式创建数据库，完成基本 sqflite 软件包的数据库打 开、关闭、表格创建等操作。
import 'package:flutter_bookkeeping/util/constant.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../constantWr.dart';

class DbHelper {
  factory DbHelper() => _getInstance();

  static DbHelper get instance => _getInstance();
  static DbHelper _instance = null;

  DbHelper._internal();

  /// 单例模式
  static DbHelper _getInstance() {
    if (_instance == null) {
      _instance = new DbHelper._internal();
    }
    return _instance;
  }

  Database _db;

  Future<Database> get db async {
    if (_db == null) _db = await _initDb();
    return _db;
  }

  /// 初始化
  _initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, DbConstant.dbName);
    return await openDatabase(
      path,
      version: DbConstant.dbVersion,
      onCreate: _onCreate,
    );
  }

  /// 创建 包括id， 名称，所属， 图片编号
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('create table ${CategoryTable.TABLE_NAME}'
        '('
        '"${CategoryTable.CATEGORY_ID}" integer primary key autoincrement,'
        '"${CategoryTable.CATEGORY_NAME}" text, '
        '"${CategoryTable.CATEGORY_BELON}" integer'
        '"${CategoryTable.CATEGORY_IMAGE_NUM}" integer'
        ')');
    await db.execute('create table ${KeepTable.TABLE_NAME}'
        '('
        '"${KeepTable.recordId}" integer primary key autoincrement, '
        '"${KeepTable.recordCategoryName}" text, '
        '"${KeepTable.recordCategoryNum}" integer'
        '"${KeepTable.recordImage}" text'
        '"${KeepTable.recordNumber}" real'
        '"${KeepTable.recordRemarks}" text'
        '"${KeepTable.recordTime}" text'
        ')');
  }

  void close() async {
    if (_db != null) await _db.close();
  }
}
