import 'package:flutter/material.dart';

import './animationWidget/animation1.dart';
import './animationWidget/animation2.dart';
import './animationWidget/animation3.dart';
import './animationWidget/animation4.dart';
import './animationWidget/animation5.dart';
import './animationWidget/animation6.dart';
import './animationWidget/ringWidget/GradientCircularProgressRoute.dart';
import './animationWidget/animation8.dart';

class TopBar extends StatefulWidget {
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 10, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('topBar'),
        bottom: TabBar(
          controller: _controller,
          isScrollable: true,
          tabs: <Widget>[
            Tab(text: '动画1'),
            Tab(text: '动画2'),
            Tab(text: '动画3'),
            Tab(text: '动画4'),
            Tab(text: '动画5'),
            Tab(text: '动画6'),
            Tab(text: '动画7'),
            Tab(text: 'Dialog'),
            Tab(text: '玖'),
            Tab(icon: Icon(Icons.business_center)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          Animation1(),
          Animation2(),
          Animation3(),
          Animation4(),
          Animation5(),
          Animation6(),
          GradientCircularProgressRoute(),
          Animation8(),
          Text('99'),
          Text('100'),
        ],
      ),
    );
  }
}
