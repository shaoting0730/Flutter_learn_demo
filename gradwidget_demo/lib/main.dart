import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
 var card = new Card(
   child: Column(
     children: <Widget>[
       ListTile(
         title: Text('中国程序员',style:TextStyle(fontWeight:FontWeight.w600)),
         subtitle: Text('待遇:人傻钱多死得早'),
         leading: new Icon(Icons.account_box,color:Colors.redAccent),
       ),
       new Divider(
         color: Colors.red,
         height: 20.0,
       ),
       ListTile(
         title: Text('日本程序员',style:TextStyle(fontWeight:FontWeight.w600)),
         subtitle: Text('待遇:一群死宅'),
         leading: new Icon(Icons.account_box,color:Colors.redAccent),
       ),
        new Divider(
         color: Colors.red,
         height: 20.0,
       ),
       ListTile(
         title: Text('美国程序员',style:TextStyle(fontWeight:FontWeight.w600)),
         subtitle: Text('待遇:技术宅改变世界'),
         leading: new Icon(Icons.account_box,color:Colors.redAccent),
       ),
     ],
   ),
 );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('gradWidget')),
        body: card,
      ),
    );
  }
}



