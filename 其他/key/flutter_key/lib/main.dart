import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int count = 0;
  GlobalKey<_TextWidgetState> textKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextWidget(textKey),
            Text(
              count.toString(),
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),

            ///这个Text不会刷新，只会刷新上面的TextWidget
            FlatButton(
              child: new Text('按钮 $count'),
              color: Theme.of(context).accentColor,
              onPressed: () {
                count++; // 这里我们只给他值变动，状态刷新交给下面的Key事件
                textKey.currentState
                    .onPressed(count); //其实这个count值已经改变了 但是没有重绘所以我们看到的只是我们定义的初始值
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TextWidget extends StatefulWidget {
  final Key key;
  TextWidget(this.key);

  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  String text = "0";

  void onPressed(int count) {
    setState(() {
      text = count.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
