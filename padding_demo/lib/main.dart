import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /**
     * 
     *  Padding({
     *  ...
     *  EdgeInsetsGeometry padding,
     *  Widget child,
     *  })
     * 
     */
    return MaterialApp(
      title: 'Padding',
      home: Scaffold(
        appBar: AppBar(title: Text('Padding')),
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0), // 上下左右各添加16像素留白
                  child: Image.network(
                      'http://ww1.sinaimg.cn/large/0065oQSqly1frepr2rhxvj30qo0yjth8.jpg'),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0), // 只需左添加10像素留白
                  child: Image.network(
                      'http://ww1.sinaimg.cn/large/0065oQSqly1frepr2rhxvj30qo0yjth8.jpg'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0), //上下各添加12像素留白
                  child: Image.network('http://ww1.sinaimg.cn/large/0065oQSqly1frepr2rhxvj30qo0yjth8.jpg'),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0), // 分别指定四个方向的20补白
                  child: Image.network('http://ww1.sinaimg.cn/large/0065oQSqly1frepr2rhxvj30qo0yjth8.jpg'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
