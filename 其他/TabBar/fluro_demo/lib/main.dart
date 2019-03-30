import 'package:flutter/material.dart';
import 'tabbar.dart';
import 'package:fluro/fluro.dart';
import './routers/application.dart';
import './routers/routers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router =Router();
    Routers.configureRouters(router);
    Application.router = router;
    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: Application.router.generator,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Tabbar(),
    );
  }
}
