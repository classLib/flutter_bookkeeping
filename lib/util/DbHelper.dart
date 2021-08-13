// 基于单例模式创建数据库，完成基本 sqflite 软件包的数据库打 开、关闭、表格创建等操作。
import 'package:flutter_bookkeeping/model/categorySetting/category.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../constantWr.dart';
class DbHelper {

  static final DbHelper _instance = DbHelper._internal();

  factory DbHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db == null) _db = await _initDb();
    return _db;
  }

  DbHelper._internal();

  //创建数据库
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
  void _onCreate(Database db, int version) async {
    // await db.execute('create table ${CategoryTable.TABLE_NAME}'
    //     '('
    //     '"${CategoryTable.CATEGORY_ID}" integer primary key autoincrement,'
    //     '"${CategoryTable.CATEGORY_NAME}" text'
    //     '"${CategoryTable.CATEGORY_BELON}" integer'
    //     '"${CategoryTable.CATEGORY_IMAGE_NUM}" text'
    //     ')');

    db.execute(
        "CREATE TABLE ${CategoryTable.TABLE_NAME}("
            "${CategoryTable.CATEGORY_ID} INTEGER PRIMARY KEY, "
            "${CategoryTable.CATEGORY_NAME} TEXT, "
            "${CategoryTable.CATEGORY_BELON} INTEGER, "
            "${CategoryTable.CATEGORY_IMAGE_NUM} TEXT)"
    );
    print("数据库创建完毕");
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
      catetory.id = await __db.insert(CategoryTable.TABLE_NAME, catetory.toMap());
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
