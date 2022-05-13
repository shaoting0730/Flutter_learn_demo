import 'dart:async';

import 'package:flutter/material.dart';

class StreamWidget1 extends StatefulWidget {
  const StreamWidget1({Key? key}) : super(key: key);

  @override
  State<StreamWidget1> createState() => _StreamWidget1State();
}

class _StreamWidget1State extends State<StreamWidget1> {
  final _controller = StreamController();
  // 单播可缓存

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }

  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 5), () {
    //   _controller.stream.listen((event) {
    //     print(event);
    //   });
    // });
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
