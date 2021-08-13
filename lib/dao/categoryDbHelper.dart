// //关于类别的增删改
//
// import 'package:flutter_bookkeeping/model/categorySetting/category.dart';
// import 'package:flutter_bookkeeping/util/DbHelper.dart';
//
// import '../constantWr.dart';
//
// class CategoryDbHelper {
// //  新增
//   static Future<Catetory> insert(Catetory catetory) async {
//     var __db = await DbHelper.instance.db;
//     try {
//       catetory.id = await __db.insert(CategoryTable.TABLE_NAME, catetory.toMap());
//     } catch (e) {
//       print(e);
//     }
//     print("数据${catetory.category_name}已存入数据库");
//     return catetory;
//   }
// //  通过id查找
//   static Future<Catetory> query(int id) async {
//     var __db = await DbHelper.instance.db;
//     List<Map> maps = await __db
//         .query(CategoryTable.TABLE_NAME, where: '${CategoryTable.CATEGORY_ID} = ?', whereArgs: [id]);
//     if (maps.length > 0) return Catetory.fromMap(maps.first);
//     return null;
//   }
// //  通过类别名称查找
//   static Future<List<Catetory>> search(String key) async {
//     var __db = await DbHelper.instance.db;
//     List<Map> maps = await __db.query(CategoryTable.TABLE_NAME,
//         where: '${CategoryTable.CATEGORY_NAME} like %?%', whereArgs: [key]);
//     var list = List<Catetory>();
//     maps.forEach((element) {
//       list.add(Catetory.fromMap(element));
//     });
//     print("类别${key}已查找到");
//     return list;
//   }
// //  查询全部
//   static Future<List<Catetory>> queryAll() async {
//     var __db = await DbHelper.instance.db;
//     List<Map> maps = await __db.query(CategoryTable.TABLE_NAME);
//     var list = [];
//     maps.forEach((element) {
//       list.add(Catetory.fromMap(element));
//     });
//     return list;
//   }
// // 删除全部
//   static Future<int> deleteAll() async {
//     var __db = await DbHelper.instance.db;
//
//     return await __db.delete(CategoryTable.TABLE_NAME);
//   }
// //通过id删除
//   static Future<int> deleteById(int id) async {
//     var __db = await DbHelper.instance.db;
//
//     return await __db
//         .delete(CategoryTable.TABLE_NAME, where: '${CategoryTable.CATEGORY_ID} = ?', whereArgs: [id]);
//   }
//
// }