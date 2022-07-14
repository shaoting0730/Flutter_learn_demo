import 'package:flutter/material.dart';
import 'package:keep_alive_demo/pages/keep_alive_list_view_demo.dart';
import 'package:keep_alive_demo/pages/StateLiftListView.dart';
import 'package:keep_alive_demo/pages/list_view_demo.dart';

class TopBar extends StatefulWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
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
        title: const Text('topBar'),
        bottom: TabBar(
          controller: _controller,
          isScrollable: true,
          tabs: const <Widget>[
            Tab(text: '基本ListView'),
            Tab(text: '状态提升ListView'),
            Tab(text: 'keepAlive的ListView'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: const <Widget>[
          ListViewDemo(),
          StateLiftListView(),
          KeepAliveListViewDemo(),
        ],
      ),
    );
  }
}
