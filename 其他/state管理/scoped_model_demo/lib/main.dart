
import 'package:flutter/material.dart';
import 'package:scoped_model_demo/model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'top_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    //创建顶层状态
  MainModel countModel = MainModel();
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: countModel,
      child: new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TopScreen(),
      ),
    );
  }
}