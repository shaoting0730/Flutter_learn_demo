import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _ignoring = false; // 禁用
  bool _greyTag = true; // 至灰色

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
          _greyTag == true ? Colors.transparent : Colors.grey, BlendMode.color),
      child: MaterialApp(
        title: 'Flutter Fly',
        home: Scaffold(
          appBar: AppBar(
            title: Text('禁用和置灰'),
          ),
          floatingActionButton: IconButton(
            icon: Icon(Icons.adb),
            onPressed: () {
              setState(() {
                _ignoring = !_ignoring;
              });
            },
          ),
          body: IgnorePointer(
            ignoring: _ignoring,
            child: ListView(
              children: <Widget>[
                Image.network(
                  'https://ae01.alicdn.com/kf/U1368d87586bd4c51a0f84541dbe329eaW.jpg',
                  height: 500,
                ),
                InkWell(
                  onTap: () {
                    print('我还可以点击');
                    setState(() {
                      _greyTag = !_greyTag;
                    });
                  },
                  child: Text(
                    '置灰切换',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
