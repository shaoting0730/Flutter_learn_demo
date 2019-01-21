import 'package:flutter/material.dart';
import 'package:tabbar_demo/pages/homepage.dart';
import 'package:tabbar_demo/pages/showpage.dart';
import 'package:tabbar_demo/pages/minepage.dart';

class Tabbar extends StatefulWidget {
  _Tabbar createState() => _Tabbar();
}

class _Tabbar extends State<Tabbar> {
  final _tabbarColor = Colors.blue;
  int _currentIndex = 0;
  List<Widget> tablist = List();

  @override
  void initState() {
    tablist..add(Homepage())..add(Showpage())..add(Minepage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tablist[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _tabbarColor),
            title: Text(
              '首页',
              style: TextStyle(color: _tabbarColor),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hotel, color: _tabbarColor),
            title: Text(
              '展示',
              style: TextStyle(color: _tabbarColor),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info, color: _tabbarColor),
            title: Text(
              '个人中心',
              style: TextStyle(color: _tabbarColor),
            ),
          )
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
