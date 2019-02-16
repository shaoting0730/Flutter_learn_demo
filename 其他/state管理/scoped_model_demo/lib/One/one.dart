import 'package:flutter/material.dart';
import 'package:scoped_model_demo/model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

class One extends StatefulWidget {
  @override
  _OneState createState() => _OneState();
}

class _OneState extends State<One> {
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
      builder: (context, child, model) {
        return Scaffold(
          appBar: AppBar(
            title: Text('One One'),
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                Text(
                  model.count.toString(),
                  style: TextStyle(fontSize: 22.0),
                ),
                RaisedButton(
                  child: Text('加1'),
                  onPressed: () => model.increment(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
