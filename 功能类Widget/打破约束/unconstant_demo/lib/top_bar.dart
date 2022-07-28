import 'package:flutter/material.dart';

class TopWidget extends StatefulWidget {
  const TopWidget({Key? key}) : super(key: key);

  @override
  _TopWidgetState createState() => _TopWidgetState();
}

class _TopWidgetState extends State<TopWidget> with SingleTickerProviderStateMixin {
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
        title: const Text('打破约束'),
        bottom: TabBar(
          controller: _controller,
          isScrollable: true,
          tabs: const <Widget>[
            Tab(text: 'UnconstrainedBox'),
            Tab(text: 'OverflowBox'),
            Tab(text: 'SizeOverfowBox'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: const <Widget>[
          UnconstrainedBoxDemo(),
          OverflowBoxDemo(),
          SizeOverfowBoxDemo(),
        ],
      ),
    );
  }
}

// UnconstrainedBox
class UnconstrainedBoxDemo extends StatefulWidget {
  const UnconstrainedBoxDemo({Key? key}) : super(key: key);

  @override
  State<UnconstrainedBoxDemo> createState() => _UnconstrainedBoxDemoState();
}

class _UnconstrainedBoxDemoState extends State<UnconstrainedBoxDemo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200,
        height: 200,
        child: UnconstrainedBox(
          child: Container(
            color: Colors.grey,
            width: 300,
            height: 300,
          ),
        ),
      ),
    );
  }
}

// OverflowBox
class OverflowBoxDemo extends StatefulWidget {
  const OverflowBoxDemo({Key? key}) : super(key: key);

  @override
  State<OverflowBoxDemo> createState() => _OverflowBoxDemoState();
}

class _OverflowBoxDemoState extends State<OverflowBoxDemo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        color: Colors.red,
        child: const OverflowBox(
          minHeight: 150,
          minWidth: 150,
          maxHeight: 150,
          maxWidth: 150,
          child: FlutterLogo(),
        ),
      ),
    );
  }
}

// SizeOverfowBox
class SizeOverfowBoxDemo extends StatefulWidget {
  const SizeOverfowBoxDemo({Key? key}) : super(key: key);

  @override
  State<SizeOverfowBoxDemo> createState() => _SizeOverfowBoxDemoState();
}

class _SizeOverfowBoxDemoState extends State<SizeOverfowBoxDemo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        color: Colors.grey,
        alignment: Alignment.bottomRight,
        child: SizedOverflowBox(
          size: const Size(50, 50),
          alignment: Alignment.topLeft,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.black45,
          ),
        ),
      ),
    );
  }
}
