import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo1/tabbar.dart';
import 'package:provider_demo1/provider/color_provider.dart';
import 'package:provider_demo1/provider/counter_provider.dart';

void main() {
  var colorProvider = ColorProvider();
  var counterProvider = CounterProvider();
  Provider.debugCheckInvalidValueType = null;

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: colorProvider),
      ChangeNotifierProvider.value(value: counterProvider),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<CounterProvider>(
      builder: (context, model, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Tabbar(),
        );
      },
    );
  }
}
