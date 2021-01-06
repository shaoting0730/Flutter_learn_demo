import 'package:flutter/material.dart';
import 'package:provider_demo1/pages/one_pege.dart';
import 'package:provider_demo1/pages/two_page.dart';

class Tabbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false, home: new MainPageWidget());
  }
}

class MainPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPageWidget> {
  int _tabIndex = 0;
  var tabImages;
  var appBarTitles = ['One', 'Two'];
  /*
   * 存放二个页面，跟fragmentList一样
   */
  var _pageList;

  /*
   * 根据选择获得对应的normal或是press的icon
   */
  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  /*
   * 获取bottomTab的颜色和文字
   */
  String getTabTitle(int curIndex) {
    if (curIndex == _tabIndex) {
      return appBarTitles[curIndex];
    } else {
      return appBarTitles[curIndex];
    }
  }

  /*
   * 根据image路径获取图片
   */
  Image getTabImage(path) {
    return new Image.asset(path, width: 24.0, height: 24.0);
  }

  void initData() {
    /*
     * 初始化选中和未选中的icon
     */
    tabImages = [
      [
        getTabImage('images/tab/home.png'),
        getTabImage('images/tab/home_select.png')
      ],
      [
        getTabImage('images/tab/show.png'),
        getTabImage('images/tab/show_select.png')
      ],
    ];
    /*
     * 子界面
     */
    _pageList = [
      new OnePage(),
      new TwoPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    //初始化数据
    initData();
    return Scaffold(
        body: _pageList[_tabIndex],
        bottomNavigationBar: new BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
                icon: getTabIcon(0), label: getTabTitle(0)),
            new BottomNavigationBarItem(
                icon: getTabIcon(1), label: getTabTitle(1)),
          ],
          type: BottomNavigationBarType.fixed,
          //默认选中首页
          currentIndex: _tabIndex,
          iconSize: 24.0,
          //点击事件
          onTap: (index) {
            setState(() {
              _tabIndex = index;
            });
          },
        ));
  }
}
