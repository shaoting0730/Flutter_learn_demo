import 'package:flutter/material.dart';
import 'package:scoped_model_demo/model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'tabbar.dart';

class TopScreen extends StatefulWidget {
  @override
  _TopScreenState createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  //静态获取model用法实例
  Model getModel(BuildContext context) {
    //直接使用of
    final countModel = ScopedModel.of<MainModel>(context);
    //使用CountModel中重写的of
    final countModel2 = MainModel().of(context);

    countModel.increment();
    countModel2.increment();
    return countModel;
    //    return countMode2;
  }


  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context,child,model){
        return Tabbar();
      },
    );
  }
}