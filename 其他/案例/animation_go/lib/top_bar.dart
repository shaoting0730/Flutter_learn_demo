import 'package:flutter/material.dart';
import 'package:animation_go/animations/slide_verify_widget.dart';

class Topbar extends StatefulWidget {
  const Topbar({Key? key}) : super(key: key);

  @override
  _TopbarState createState() => _TopbarState();
}

class _TopbarState extends State<Topbar> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('topBar'),
        bottom: TabBar(
          controller: _controller,
          tabs: [
            Tab(text: '滑动解锁'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          Row(
            children: [
              SlideVerifyWidget(
                verifySuccessListener: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
