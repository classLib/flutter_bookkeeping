


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookkeeping/dao/keepDbHelper.dart';
import 'package:flutter_bookkeeping/model/keepSetting/keep_record.dart';
import 'package:flutter_bookkeeping/util/DbHelper.dart';


class BookKeepingDdatabaseTest extends StatefulWidget {

  final DbHelper kookingProvider = new DbHelper();

  @override
  State<StatefulWidget> createState() {
    return new _BookKeepingDdatabaseTestState();
  }
}

class _BookKeepingDdatabaseTestState extends State<BookKeepingDdatabaseTest> {
  TextEditingController textController = new TextEditingController();

  // ignore: deprecated_member_use
  List<KeepRecord> taskList = new List();

  @override
  void initState() async{
    super .initState();
    // // KeepDbHelper.queryAll();
    await KeepDbHelper.queryAll().then((value) {
      setState(() {
        value.forEach((element) {
          taskList.add(element);
        });
        print(taskList.length);
      });
    }).catchError((error) {
      print(error);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测试'),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all( 16 ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "Enter a task" ),
                    controller: textController,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addToDb,
                )
              ],
            ),
            SizedBox(height: 20 ),
            Expanded(
              child: Container(
                child: taskList.isEmpty
                    ? Container()
                    : ListView.builder(itemBuilder: (ctx, index) {
                  if (index == taskList.length) return null ;
                  return ListTile(
                    title: Text(taskList[index].id.toString()),
                    leading: Text(taskList[index].id.toString()),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteTask(taskList[index].id),
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
  void _deleteTask( int id) async {
    // await KeepDbHelper.deleteById(id);
    setState(() {
      taskList.removeWhere((element) => element.id == id);
    });
  }
  void _addToDb() async {
    String task = textController.text;

    KeepRecord keepRecord = new KeepRecord('餐饮',1,'2021-8-15','assets/canyin.png','这是餐饮的第一条数据',20);
    KeepRecord keepRecord2 = new KeepRecord('服饰',1,'2021-8-15','assets/fushi-_1.png','这是服饰的第一条数据',102);
    KeepRecord keepRecord3 = new KeepRecord('零食',1,'2021-8-15','assets/lingshi_2.png','这是零食的第一条数据',20);

    var id = await KeepDbHelper.insert(keepRecord);
    var id1 = await KeepDbHelper.insert(keepRecord2);
    var id2 = await KeepDbHelper.insert(keepRecord3);
    KeepRecord test = await KeepDbHelper.query(1);

    setState(() {
      taskList.insert( 0 ,keepRecord);
      taskList.insert( 0 ,keepRecord2);
      taskList.insert( 0 ,keepRecord3);

    });
  }


}