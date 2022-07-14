import 'package:flutter/material.dart';

class ListViewDemo extends StatefulWidget {
  const ListViewDemo({Key? key}) : super(key: key);

  @override
  State<ListViewDemo> createState() => _ListViewDemoState();
}

class _ListViewDemoState extends State<ListViewDemo> {
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

class _CounterState extends State<Counter> {
  late int _count = 0;

  @override
  Widget build(BuildContext context) {
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
}
