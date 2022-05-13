import 'dart:async';

import 'package:flutter/material.dart';

class StreamWidget2 extends StatefulWidget {
  const StreamWidget2({Key? key}) : super(key: key);

  @override
  State<StreamWidget2> createState() => _StreamWidget2State();
}

class _StreamWidget2State extends State<StreamWidget2> {
  final _controller = StreamController.broadcast();
  // 广播不可以缓存
  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }

  @override
  void initState() {
    super.initState();
    _controller.stream.listen((event) {
      print(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            _controller.sink.add(10);
          },
          child: const Text('10'),
        ),
        ElevatedButton(
          onPressed: () {
            _controller.sink.add(20);
          },
          child: const Text('Hello'),
        ),
        ElevatedButton(
          onPressed: () {
            _controller.sink.addError('【出错】');
          },
          child: const Text('出错'),
        ),
        ElevatedButton(
          onPressed: () {
            _controller.sink.close();
          },
          child: const Text('close'),
        ),
        StreamBuilder(
          stream: _controller.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Text('NONE:没有数据流');
                break;
              case ConnectionState.waiting:
                return const Text('WAITING:等待数据流');
                break;
              case ConnectionState.active:
                if (snapshot.hasError) {
                  return Text('ACTIVE:${snapshot.error}');
                } else {
                  return Text('ACTIVE:${snapshot.data}');
                }
                break;
              case ConnectionState.done:
                return const Text('DONE:数据流已经关闭');
                break;
            }
          },
        )
      ],
    );
  }
}
