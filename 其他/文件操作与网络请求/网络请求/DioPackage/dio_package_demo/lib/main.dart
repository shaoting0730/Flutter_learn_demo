import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';

// https://github.com/flutterchina/dio
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
        title: Text('dio pakeage'),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('get'),
            onPressed: () => getDataAction(),
          ),
          RaisedButton(
            child: Text('post'),
            onPressed: () => postDataAction(),
          ),
          Text.rich(TextSpan(children: [
            TextSpan(text: "更多请参考dio github : "),
            TextSpan(
              text: "https://github.com/flutterchina/dio",
              style: TextStyle(color: Colors.blue),
              recognizer:new TapGestureRecognizer()..onTap=(){//增加一个点击事件
                 print('点击了');
              },
            ),
          ])),
        ],
      ),
    );
  }

  void getDataAction() async {
    try {
      Response response;
      response =
          await Dio().get("https://gank.io/api/data/%E7%A6%8F%E5%88%A9/10/1");
      return print(response);
    } catch (e) {
      return print(e);
    }
  }

  void postDataAction() async {
    try {
      Response response;
      response = await Dio().post("/test", data: {'xxx': 123, 'yyy': 'YYY'});
      return print(response);
    } catch (e) {
      return print(e);
    }
  }
}
