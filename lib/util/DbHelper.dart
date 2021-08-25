// 基于单例模式创建数据库，完成基本 sqflite 软件包的数据库打 开、关闭、表格创建等操作。
import 'package:flutter_bookkeeping/model/categorySetting/category.dart';
import 'package:flutter_bookkeeping/model/keepSetting/keep_record.dart';


import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../constantWr.dart';
import 'constant.dart';

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

  static Database _db;

  Future<Database> get db async {
    if (_db == null) _db = await _initDb();
    return _db;
  }

  //创建数据库

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


  //创建数据库表
  /// 创建 包括id， 名称，所属， 图片编号
  Future<void> _onCreate(Database db, int version) async {

    db.execute(
        "CREATE TABLE ${CategoryTable.TABLE_NAME}("
            "${CategoryTable.CATEGORY_ID} INTEGER PRIMARY KEY, "
            "${CategoryTable.CATEGORY_NAME} TEXT, "
            "${CategoryTable.CATEGORY_BELON} INTEGER, "
            "${CategoryTable.CATEGORY_IMAGE_NUM} TEXT)"
    );

    // await db.execute('CREATE TABLE ${KeepTable.TABLE_NAME}'
    //     '('
    //     '"${KeepTable.recordId}" INTEGER PRIMARY KEY, '
    //     '"${KeepTable.recordCategoryName}" TEXT, '
    //     '"${KeepTable.recordCategoryNum}" INTEGER'
    //     '"${KeepTable.recordImage}" TEXT'
    //     '"${KeepTable.recordNumber}" REAL'
    //     '"${KeepTable.recordRemarks}" TEXT'
    //     '"${KeepTable.recordTime}" TEXT'
    //     ')');

    print("分类表创建完毕");
    db.execute(
        "CREATE TABLE ${KeepTable.TABLE_NAME}("
            "${KeepTable.recordId} INTEGER PRIMARY KEY, "
            "${KeepTable.recordCategoryName} TEXT, "
            "${KeepTable.recordCategoryNum} INTEGER, "
            "${KeepTable.recordTime} TEXT, "
            "${KeepTable.recordImage} TEXT, "
            "${KeepTable.recordRemarks} TEXT, "
            "${KeepTable.recordNumber} REAL)"
    );
    print("收支记录表创建完毕");
    return ;
  }

  //关闭数据库
  Future close() async {
    var _dbClient = await db;
    return _dbClient.close();
  }



  //  新增
  Future<Catetory> insert(Catetory catetory) async {
    var __db = await db;
    try {
      catetory.id =
      await __db.insert(CategoryTable.TABLE_NAME, catetory.toMap());
    } catch (e) {
      print(e);
    }
    print("数据${catetory.category_name}已存入数据库");
    return catetory;
  }

  //按照 id 查询数据
  Future<Catetory> query(int id) async {
    var _dbClient = await db;
    var maps = await _dbClient
        .query(CategoryTable.TABLE_NAME, where: 'id = ?', whereArgs: [id]);
    if (maps.length > 0) {
      return Catetory.fromMap(maps.first);
    }
    return null;
  }
  // 按照支出类别1来进行查找
  Future<List<Catetory>> queryByCategoryBelong(int category_belong) async {
    var _dbClient = await db;
    List<Catetory> list = [];
    var maps = await _dbClient
        .query(CategoryTable.TABLE_NAME, where: 'category_belong = ?', whereArgs: [category_belong]);
    maps.forEach((value) {
      list.add(Catetory.fromMap(value));
    });
    return list;
  }

  //按照 key 查询
  Future<List<Catetory>> search(String key) async {
    var _dbClient = await db;
    List<Map<String, dynamic>> maps = await _dbClient.query(
        CategoryTable.TABLE_NAME,
        where: 'keyword like %?%',
        whereArgs: [key]);

    List<Catetory> list = [];
    maps.forEach((value) {
      list.add(Catetory.fromMap(value));
    });
    return list;
  }

  //  查询全部
  Future<List<Catetory>> queryAll() async {
    // var __db = await db;
    // List<Map> maps = await __db.query(CategoryTable.TABLE_NAME);
    // var list = [];
    // maps.forEach((element) {
    //   list.add(Catetory.fromMap(element));
    // });
    // return list;
    var _dbClient = await db;
    List<Map<String, dynamic>> maps =
    await _dbClient.query(CategoryTable.TABLE_NAME);
    List<Catetory> list = [];
    maps.forEach((value) {
      list.add(Catetory.fromMap(value));
      print('查询的分类的名称');
      print(value['category_name']);
    });
    return list;
  }
  //删除全部数据

  Future<int> deleteAll() async {
    var _dbClient = await db;
    print("数据库中全部数据已删除");
    return await _dbClient.delete(CategoryTable.TABLE_NAME);
  }

  //根据 id 删除数据
  Future<int> delete(int id) async {
    var _dbClient = await db;
    print("id为$id的数据已被删除");
    return await _dbClient
        .delete(CategoryTable.TABLE_NAME, where: 'id = ?', whereArgs: [id]);
  }
}