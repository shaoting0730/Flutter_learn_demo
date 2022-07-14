import 'package:flutter/material.dart';

class KeepAliveListViewDemo extends StatefulWidget {
  const KeepAliveListViewDemo({Key? key}) : super(key: key);

  @override
  State<KeepAliveListViewDemo> createState() => _KeepAliveListViewDemoState();
}

class _KeepAliveListViewDemoState extends State<KeepAliveListViewDemo> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 30,
      itemExtent: 80,
      itemBuilder: (context, index) {
        return Center(
          child: Counter(index: index),
        );
      },
    );
  }
}

class Counter extends StatefulWidget {
  final int index;
  const Counter({Key? key, required this.index}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> with AutomaticKeepAliveClientMixin {
  late int _count = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _count++;
        });
      },
      child: Text(
        '这是第${widget.index}行数据，值是$_count',
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
