import 'package:flutter/material.dart';

import 'list_widgets/listview_widget1.dart';
import 'list_widgets/listview_widget2.dart';

class TopbarWidget extends StatefulWidget {
  const TopbarWidget({Key? key}) : super(key: key);

  @override
  _TopbarWidgetState createState() => _TopbarWidgetState();
}

class _TopbarWidgetState extends State<TopbarWidget> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _controller,
          isScrollable: true,
          tabs: [
            Tab(text: 'listView1'),
            Tab(text: 'listView2'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          ListViewWidget2(),
          ListViewWidget1(),
        ],
      ),
    );
  }
}
