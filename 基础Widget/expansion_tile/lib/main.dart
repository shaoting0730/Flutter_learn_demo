import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar:AppBar(title: Text('')),
        body: ExpansionTileDemo(),
      ),
    );
  }
}
/*
 * ExpansionTile Widget就是一个可以展开闭合的组件，常用的属性有如下几个。

title:闭合时显示的标题，这个部分经常使用Text Widget。
leading:标题左侧图标，多是用来修饰，让界面显得美观。
backgroundColor: 展开时的背景颜色，当然也是有过度动画的，效果非常好。
children: 子元素，是一个数组，可以放入多个元素。
trailing ： 右侧的箭头，你可以自行替换但是我觉的很少替换，因为谷歌已经表现的很完美了。
initiallyExpanded: 初始状态是否展开，为true时，是展开，默认为false，是不展开。 
 */

class ExpansionTileDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  ExpansionTile(
         title: Text('ExpansionTile Title'),
         leading: Icon(Icons.ac_unit),
         backgroundColor: Colors.white12,
         children: <Widget>[
           Text('subTitle'),
         ],
         initiallyExpanded: false,  // 默认是否打开
    );
  }
}
