import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('GridView')),
        body: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,  //列数
            mainAxisSpacing: 2.0,  //上下间隔
            crossAxisSpacing: 2.0, // 左右间隔
            childAspectRatio: 0.7, // 宽高比
          ),
          children: <Widget>[
            Image.network('https://ww1.sinaimg.cn/large/0065oQSqgy1ftrrvwjqikj30go0rtn2i.jpg',fit:BoxFit.cover,),
            Image.network('https://ws1.sinaimg.cn/large/0065oQSqly1fvexaq313uj30qo0wldr4.jpg',fit:BoxFit.cover,),
            Image.network('https://ws1.sinaimg.cn/large/0065oQSqly1fv5n6daacqj30sg10f1dw.jpg',fit:BoxFit.cover,),
            Image.network('https://ws1.sinaimg.cn/large/0065oQSqly1fuh5fsvlqcj30sg10onjk.jpg',fit:BoxFit.cover,),
            Image.network('https://ww1.sinaimg.cn/large/0065oQSqgy1fu39hosiwoj30j60qyq96.jpg',fit:BoxFit.cover,),
            Image.network('https://ww1.sinaimg.cn/large/0065oQSqly1ftzsj15hgvj30sg15hkbw.jpg',fit:BoxFit.cover,),
            Image.asset('images/download.jpg')
          ],
        ),
      )
    );
  }
}
