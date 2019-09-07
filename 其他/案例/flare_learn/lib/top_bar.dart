import 'package:flutter/material.dart';
import './flare_widgets/one.dart';
import './flare_widgets/two.dart';

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
        title: Text('Flare'),
        bottom: TabBar(
          controller: _controller,
          isScrollable: true,
          tabs: <Widget>[
            Tab(text: '壹'),
            Tab(text: '贰'),
            Tab(text: '叄'),
            Tab(text: '肆'),
            Tab(text: '伍'),
            Tab(text: '陆'),
            Tab(text: '柒'),
            Tab(text: '捌'),
            Tab(text: '玖'),
            Tab(icon: Icon(Icons.business_center)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          One(),
          Two(),
          Text('33'),
          Text('44'),
          Text('55'),
          Text('66'),
          Text('77'),
          Text('88'),
          Text('99'),
          Text('100'),
        ],
      ),
    );
  }
}
