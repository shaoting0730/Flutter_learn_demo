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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller = new AnimationController(
          duration: const Duration(milliseconds: 300), vsync: this);
      _animation =
          new Tween(begin: 0.0, end: MediaQuery.of(context).size.height)
              .animate(_controller)
                ..addListener(() {
                  setState(() {});
                });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('drop_dowm'),
      ),
      body: Column(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_downward),
            onPressed: () {
              if (_animation.status == AnimationStatus.completed) {
                _controller.reverse();
              } else {
                _controller.forward();
              }
            },
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                ListView.builder(
                  itemCount: 1000,
                  itemBuilder: (context, index) {
                    return Text(
                      '222222222222222222222222222222222222222222222222222222222222222222',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    );
                  },
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    height: _animation == null ? 0 : _animation.value,
                    width: MediaQuery.of(context).size.width,
                    child: DropDownView(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

/*
* 整体下拉view
* */
class DropDownView extends StatefulWidget {
  @override
  _DropDownViewState createState() => _DropDownViewState();
}

class _DropDownViewState extends State<DropDownView> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        children: <Widget>[
          // 下拉框中的实际内容 5/8
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.yellow,
              child: ListView.builder(
                itemCount: 90,
                itemBuilder: (context, index) {
                  return Text(
                    '============================',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  );
                },
              ),
            ),
          ),
          // 下拉框中阴影 3/8
          Expanded(
            flex: 3,
            child: _bottomShadow(),
          ),
        ],
      ),
    );
  }

  /*
  * 底部阴影
  * */
  Widget _bottomShadow() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Color.fromRGBO(0, 0, 0, 0.4),
    );
  }
}
