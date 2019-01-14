import 'package:flutter/material.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  /*
   * 
   * Stack({
   *  this.alignment = AlignmentDirectional.topStart,
   *  this.textDirection,
   *  this.fit = StackFit.loose,
   *  this.overflow = Overflow.clip,
   *  List<Widget> children = const <Widget>[],
   *  })
   */

  var stack = Center(
    child: new Stack(
    alignment: const FractionalOffset(0.5, 0.5),
    children: <Widget>[
      new CircleAvatar(
        backgroundImage: new NetworkImage('https://ww1.sinaimg.cn/large/0065oQSqgy1ftrrvwjqikj30go0rtn2i.jpg'),
        radius: 100.0,
        backgroundColor: Colors.red,
      ),
      new Container(
        decoration: new BoxDecoration(
          color: Colors.pink,
        ),
        padding: EdgeInsets.all(5.0),
        child: Text('小哥哥,你知道安利吗?'),
      )
    ],
   ),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('层叠样式')),
        body: Center(
          child: stack,
        )
      ),
    );
  }
}
