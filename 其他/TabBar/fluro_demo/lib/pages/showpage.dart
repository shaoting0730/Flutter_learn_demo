import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../routers/application.dart';

class Showpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SHOW')),
      body: Center(
        child: RaisedButton(
          onPressed: (){
              Application.router.navigateTo(context, "./other", transition: TransitionType.nativeModal);
          },
          child: Text('跳转'),
        ),
      ),
    );
  }
}
