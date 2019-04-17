import 'package:flutter/material.dart';
const APPBAR_SCROLL_OFFSET = 100;
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
  List list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  double appBarAlpha = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: NotificationListener(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0) {
                  _onScroll(scrollNotification.metrics.pixels);
                }
              },
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(bottom: 2),
                    color: Colors.pink,
                    height: 200,
                    child: ListTile(
                      title: Text(index.toString()),
                    ),
                  );
                },
              ),
            ),
          ),
          // 自定义导航栏
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Padding(padding: EdgeInsets.only(top: 20),
                  child: Text('首页'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // 滚动调用
  _onScroll(offset) {
    print(offset);
    double alpha = offset/APPBAR_SCROLL_OFFSET;
    if(alpha<0){
      alpha = 0;
    }else if(alpha > 1){
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }
}
