import 'package:flutter/material.dart';
import 'package:more_list/more_list1.dart';
import 'more_list2.dart';

class Case extends StatefulWidget {
  const Case({Key? key}) : super(key: key);

  @override
  State<Case> createState() => _CaseState();
}

class _CaseState extends State<Case> with SingleTickerProviderStateMixin {
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
        title: const Text('列表'),
        bottom: TabBar(
          controller: _controller,
          tabs: const <Widget>[
            Tab(
              child: Text('Row'),
            ),
            Tab(
              child: Text('ListView'),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: const <Widget>[
          MoreList1(),
          MoreList2(),
        ],
      ),
    );
  }
}
