import 'package:flutter/material.dart';

void main() => runApp(MyApp(
  items:new List<String>.generate(1000, (i)=>"item $i")  // 制作一个数组传给MyApp
));

class MyApp extends StatelessWidget {
   final List<String> items;  // 声明一个List
   MyApp({Key key,@required this.items}):super(key:key);  // 接收

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: new AppBar(title: new Text('动态listView')),
        body: new ListView.builder(
          itemCount: items.length,
          itemBuilder: (context,index){
            return new ListTile(
               title: new Text('${items[index]}')
            );
          },
        ),
      ),
    );
  }
}

