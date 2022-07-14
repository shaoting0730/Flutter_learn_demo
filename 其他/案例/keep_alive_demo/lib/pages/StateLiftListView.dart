import 'package:flutter/material.dart';

class StateLiftListView extends StatefulWidget {
  const StateLiftListView({Key? key}) : super(key: key);

  @override
  State<StateLiftListView> createState() => _StateLiftListViewState();
}

class _StateLiftListViewState extends State<StateLiftListView> {
  late List list = List.generate(30, (e) {
    return 0;
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 30,
      itemExtent: 80,
      itemBuilder: (context, index) {
        return Center(
          child: Counter(
            index: index,
            list: list,
            stateLiftAction: (int callBackIndex) {
              if (callBackIndex == index) {
                setState(
                  () {
                    list[index]++;
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}

class Counter extends StatefulWidget {
  final int index;
  final List list;
  final Function stateLiftAction;
  const Counter({Key? key, required this.index, required this.list, required this.stateLiftAction(int index)}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.stateLiftAction(widget.index);
      },
      child: Text(
        '这是第${widget.index}行数据，值是${widget.list[widget.index].toString()}',
      ),
    );
  }
}
