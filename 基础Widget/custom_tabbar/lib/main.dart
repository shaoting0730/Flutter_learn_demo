import 'package:flutter/material.dart';

import './bottom_bar.dart';

import './pages/one.dart';
import './pages/two.dart';

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
      home: STTabBar(),
    );
  }
}

class STTabBar extends StatefulWidget {
  @override
  _STTabBarState createState() => _STTabBarState();
}

class _STTabBarState extends State<STTabBar> {
  int _tabIndex = 0;
  double _tab_H = 70.0; // tag 高度

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _tabIndex,
        children: <Widget>[
          One(
            // 滑块
            changeTabOne: (e) {
              setState(() {
                _tab_H = e;
              });
            },
            // 高度为0
            changeTabTwo: () {
              setState(() {
                _tab_H = 0;
              });
            },
            // 高度为70
            changeTabThree: () {
              setState(() {
                _tab_H = 70;
              });
            },
          ),
          Two(),
        ],
      ),
      bottomNavigationBar: BottomBar(
        height: _tab_H,
        color: Color(0xFF999999),
        selectedColor: Color.fromRGBO(255, 175, 76, 1),
//            backgroundColor: Colors.red,
        items: [
          BottomBarItem(
            imageIcon: Image.asset(
              'assets/one.png',
              width: 40,
              height: 40,
            ),
            imageSelectedIcon: Image.asset(
              'assets/one_select.png',
              width: 40,
              height: 40,
            ),
            text: '首页',
          ),
          BottomBarItem(
            imageIcon: Image.asset(
              'assets/two.png',
              width: 40,
              height: 40,
            ),
            imageSelectedIcon: Image.asset(
              'assets/two_select.png',
              width: 40,
              height: 40,
            ),
            text: '我的',
          )
        ],
        onTabSelected: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
    );
  }
}
