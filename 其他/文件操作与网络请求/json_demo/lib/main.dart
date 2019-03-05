import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:json_demo/Data.dart';

//  flutter packages pub run build_runner build
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DataToModel(),
    );
  }
}

class DataToModel extends StatefulWidget {
  final Widget child;

  DataToModel({Key key, this.child}) : super(key: key);

  _DataToModelState createState() => _DataToModelState();
}

class _DataToModelState extends State<DataToModel> {

  Future getHomePageContent() async {
  try {
    print('开始获取首页数据');
    Response response;
    Dio dio = new Dio();
    response = await dio.get('http://gank.io/api/data/%E7%A6%8F%E5%88%A9/10/1');
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    print('ERROR 发生错误👇');
    return print(e);
  }
}

  @override
  void initState() {
    super.initState();
    getHomePageContent().then((val) {
        Data dd = Data.fromJson(val);
        print(dd.error);
        // 数组
        print(dd.results);
        // 数组第一个元素:map
        print(dd.results[0].createdAt);
        print(dd.results[0].desc);
        print(dd.results[0].publishedAt);
        print(dd.results[0].source);
        print(dd.results[0].type);
        print(dd.results[0].url);
        print(dd.results[0].used);
        print(dd.results[0].who);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('json_serializable')),
      body: Text('json_serializable'),
    );
  }
}