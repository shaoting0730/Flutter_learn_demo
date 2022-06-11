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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ScrollController _controller;
  final GlobalKey _key = GlobalKey();

  @override
  initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  dispose() {
    super.dispose();
    _controller.dispose();
  }

  _jumpAction() {
    final renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    Offset point = renderBox.localToGlobal(Offset.zero);
    // _controller.jumpTo(point.dy);
    _controller.animateTo(point.dy, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('appBar'),
      ),
      body: ListView(
        controller: _controller,
        children: _itemWidgets(),
      ),
      floatingActionButton: InkWell(
        onTap: () => _jumpAction(),
        child: const Icon(Icons.gavel),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> _itemWidgets() {
    List<Widget> listOneWidget = List.generate(
      5,
      (index) => Container(
        margin: const EdgeInsets.only(top: 5),
        color: Colors.red,
        height: 100,
      ),
    ).toList();

    List<Widget> listTwoWidget = List.generate(
      8,
      (index) => Container(
        margin: const EdgeInsets.only(top: 5),
        color: Colors.blue,
        height: 30,
      ),
    ).toList();

    List<Widget> listThreeWidget = List.generate(
      8,
      (index) => Container(
        margin: const EdgeInsets.only(top: 8),
        color: Colors.blue,
        height: 55,
      ),
    ).toList();

    List<Widget> listWidget = [];
    listWidget.addAll(listOneWidget);
    listWidget.addAll(listTwoWidget);

    String txt = '**********************\n';
    listWidget.add(
      Container(
        key: _key,
        margin: const EdgeInsets.symmetric(vertical: 10),
        color: Colors.cyan,
        child: Text(txt * 5),
      ),
    );

    listWidget.addAll(listThreeWidget);

    return listWidget;
  }
}
