import 'package:flutter/material.dart';
import './custom_dialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义dialog'),
      ),
      body: ListView(
        children: <Widget>[
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialog(
                    isNeedTag: true,
                    okCallback: (text) {
                      print(text);
                    },
                    dismissCallback: () {
                      print("input 取消了");
                    },
                  );
                },
              );
            },
            child: Text('第一个'),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialog(
                    isNeedTag: false,
                    okCallback: (text) {
                      print(text);
                    },
                    dismissCallback: () {
                      print("slide 取消了");
                    },
                  );
                },
              );
            },
            child: Text('第二个'),
          )
        ],
      ),
    );
  }
}
