import 'package:flutter/material.dart';

void main(){
   runApp(MaterialApp(
      title: "导航演示01",
      home: new FirstScreen(),
   ));
}

class FirstScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FirstScreen')),
      body:Center(
        child:RaisedButton(
          child: Text('push 到详情子页面'),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => new SecondScreen(),
            ));
          },
        ),
      )
    );
  }
}

 class SecondScreen extends StatelessWidget {
   @override
   Widget build(BuildContext context){
     return Scaffold(
       appBar: AppBar(title: Text('子页面')),
       body: Center(
         child: RaisedButton(
           child: Text('返回'),
           onPressed: (){
             Navigator.pop(context);
           },
         ),
       ),
     );
   }
 }
