import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: CRUD(),
    );
  }
}

class CRUD extends StatefulWidget {
  final Widget child;

  CRUD({Key key, this.child}) : super(key: key);

  _CRUDState createState() => _CRUDState();
}

class _CRUDState extends State<CRUD> {
  Database db;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('数组库-增删改查')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            OutlineButton(child: Text('创建数据库和一张表'), onPressed: _createTable),
            OutlineButton(child: Text('查询数据'), onPressed: _queryData),
            OutlineButton(child: Text('插入数据'), onPressed: _insertData),
            OutlineButton(child: Text('更新数据'), onPressed: _updateData),
            OutlineButton(child: Text('删除数据'), onPressed: _deleteData),
            OutlineButton(child: Text('关闭数据库'), onPressed: _closeData),
            OutlineButton(child: Text('删除数据库'), onPressed: _deleteTable),
          ],
        ),
      ),
    );
  }

  // 创建数据库 和 表
  void _createTable() async {
    // 获取数据库文件的存储路径
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    //根据数据库文件路径和数据库版本号创建数据库表
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
    });
    print('创建数据库 和 表');
  }

  // 增
  void _insertData() async {
    await db.transaction((txn) async {
      await txn.rawInsert('INSERT INTO Test(name, value, num) VALUES(?, ?, ?)',
          ['flutter==>', 0101010101001, 1111111111111111111]);
      print('插入数据');
    });
  }

  // 删
  void _deleteData() async {
    await db.rawDelete('DELETE FROM Test WHERE name = ?', ['updated name']);
    print('删除');
  }

  // 改
  void _updateData() async {
   await db.rawUpdate(
    'UPDATE Test SET name = ?, VALUE = ?,num = ? ',
    ['updated name', 0,1]);
   print('修改');
  }

  // 查
  void _queryData() async {
    List<Map> maps = await db.query('Test');
    print(maps);
  }

  // 关闭数据库
  void _closeData() async {
    await db.close();
    print('关闭数据库');
  }

  // 删除数据库
  void _deleteTable() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    await deleteDatabase(path);
    print('删除数据库');
  }
}
