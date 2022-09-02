import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  final _containerKey = GlobalKey();
  final _ZstStatetKey = GlobalKey();
  final _ZSTKey = GlobalKey();

  _getWidgetInfo() {
    // key currentContext
    RenderBox renderBox = _containerKey.currentContext!.findRenderObject() as RenderBox;
    print('此Container的坐标 ${renderBox.localToGlobal(Offset.zero)}');
    print('此Container的宽高 ${_containerKey.currentContext!.size}');
    // key currentWidget
    final widget = _ZSTKey.currentWidget as ZST;
    print('ZST该组件下的num属性是 ${widget.num}');
    widget.btnOnclik(); // 调用其他Widget的方法
    // key  currentState
    var count = (_ZstStatetKey.currentState as _ZstStateState)._count;
    print('ZstState该组件下的state是$count');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            key: _containerKey,
            color: Colors.red,
            width: 200,
            height: 222,
          ),
          ZST(
            num: 22,
            key: _ZSTKey,
          ),
          ZstState(
            key: _ZstStatetKey,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.swipe_down),
        onPressed: () => _getWidgetInfo(),
      ),
    );
  }
}

/**************ZST*******************/

class ZST extends StatelessWidget {
  final int num;
  const ZST({Key? key, required this.num}) : super(key: key);

  btnOnclik() {
    print('ZST点击一次');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => btnOnclik(),
      child: const Text('zst'),
    );
  }
}

/**************ZstState*******************/
class ZstState extends StatefulWidget {
  const ZstState({Key? key}) : super(key: key);

  @override
  State<ZstState> createState() => _ZstStateState();
}

class _ZstStateState extends State<ZstState> {
  int _count = 0;

  addAction() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan,
      child: InkWell(
        onTap: () => addAction(),
        child: Text('count++ \n $_count'),
      ),
    );
  }
}
