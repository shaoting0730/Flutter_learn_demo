import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        // 脚手架
        appBar: AppBar(title: Text('image')), //AppBar
        body: Column(
          // 列 widget
          children: <Widget>[
            /**
             * const Image({
             * ...
             * this.width, //图片的宽
             * this.height, //图片高度
             * this.color, //图片的混合色值
             * this.colorBlendMode, //混合模式
             * this.fit,//缩放模式
             * this.alignment = Alignment.center, //对齐方式
             * this.repeat = ImageRepeat.noRepeat, //重复方式
             * ...
             * })
             */
            // 网络图片
            Image.network(
              'https://ww1.sinaimg.cn/large/0065oQSqly1ftf1snjrjuj30se10r1kx.jpg',
              width: 200.0,
              height: 200.0,
            ),
            // 本地图片
            Image.asset(
              'images/cute.jpeg',
              width: 200.0,
              height: 200.0,
            ),
            // 本地动图 常用css
            Image.asset(
              'images/cute1.gif',
              width: 200.0,
              height: 200.0,
              fit: BoxFit.cover,
              repeat: ImageRepeat.noRepeat,
              color: Colors.blue,
              colorBlendMode: BlendMode.difference,
            ),
          ],
        ),
      ),
    );
  }
}
