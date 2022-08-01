import 'package:flutter/material.dart';
import 'package:riverpod_demo/pages/one_page/one_page.dart';
import 'package:riverpod_demo/pages/two_page/two_page.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<TabBarWidget> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  int _tabIndex = 0;
  List tabImages = [];
  var appBarTitles = ['One', 'Two'];
  List _pageList = [];

  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  String getTabTitle(int curIndex) {
    if (curIndex == _tabIndex) {
      return appBarTitles[curIndex];
    } else {
      return appBarTitles[curIndex];
    }
  }

  Image getTabImage(path) {
    return Image.asset(path, width: 24.0, height: 24.0);
  }

  void initData() {
    /*
     * 初始化选中和未选中的icon
     */
    tabImages = [
      [getTabImage('images/tab/home.png'), getTabImage('images/tab/home_select.png')],
      [getTabImage('images/tab/show.png'), getTabImage('images/tab/show_select.png')],
    ];
    /*
     * 子界面
     */
    _pageList = [
      const OnePage(),
      const TwoPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList[_tabIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: getTabIcon(0), label: getTabTitle(0)),
          BottomNavigationBarItem(icon: getTabIcon(1), label: getTabTitle(1)),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _tabIndex,
        iconSize: 24.0,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
    );
  }
}
