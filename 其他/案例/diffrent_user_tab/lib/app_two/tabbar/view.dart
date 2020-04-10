import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import './state.dart';
import '../one_tab/page.dart';
import '../two_tab/page.dart';
import '../three_tab/page.dart';
import '../tabbar/action.dart';

Widget buildView(
    TabbarState state, Dispatch dispatch, ViewService viewService) {
  var tabImages;
  var appBarTitles = ['首页', '她的', '我的'];

  /*
   * 根据选择获得对应的normal或是press的icon
   */
  Image getTabIcon(int curIndex) {
    if (curIndex == state.index) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  /*
   * 获取bottomTab的颜色和文字
   */
  Text getTabTitle(int curIndex) {
    if (curIndex == state.index) {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 14.0, color: Colors.red));
    } else {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(fontSize: 14.0, color: Colors.black));
    }
  }

  /*
   * 根据image路径获取图片
   */
  Image getTabImage(path) {
    return new Image.asset(path, width: 24.0, height: 24.0);
  }

  /*
     * 初始化选中和未选中的icon
     */
  tabImages = [
    [
      getTabImage('images/tab/home.png'),
      getTabImage('images/tab//home_select.png')
    ],
    [
      getTabImage('images/tab/hers.png'),
      getTabImage('images/tab//hers_select.png')
    ],
    [
      getTabImage('images/tab/mine.png'),
      getTabImage('images/tab//mine_select.png')
    ]
  ];

  return Scaffold(
    body: IndexedStack(
      children: <Widget>[
        OnePage().buildPage(null),
        TwoPage().buildPage(null),
        ThreePage().buildPage(null),
      ],
      index: state.index,
    ),
    bottomNavigationBar: new BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        new BottomNavigationBarItem(icon: getTabIcon(0), title: getTabTitle(0)),
        new BottomNavigationBarItem(icon: getTabIcon(1), title: getTabTitle(1)),
        new BottomNavigationBarItem(icon: getTabIcon(2), title: getTabTitle(2)),
      ],
      type: BottomNavigationBarType.fixed,
      //默认选中首页
      currentIndex: state.index,
      iconSize: 24.0,
      //点击事件
      onTap: (index) {
        dispatch(TabbarActionCreator.switchIndex(index));
      },
    ),
  );
}
