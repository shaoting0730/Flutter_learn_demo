import 'package:flutter/material.dart';
import 'package:stream_demo/stream_demo1.dart';
import 'package:stream_demo/stream_demo2.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({Key? key}) : super(key: key);

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Stream'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: '单播'),
              Tab(text: '广播'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            StreamWidget1(),
            StreamWidget2(),
          ],
        ));
  }
}
