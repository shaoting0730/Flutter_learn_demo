import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyColor(
        color: Colors.yellow,
        string: '我是',
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColor.of(context)?.color,
      child: Text('${MyColor.of(context)?.string}'),
    );
  }
}

class MyColor extends InheritedWidget {
  final Color color;
  final String string;
  MyColor({
    required this.color,
    required this.string,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(MyColor oldWidget) => oldWidget.color != color || oldWidget.string != string;

  static MyColor? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<MyColor>();
}
