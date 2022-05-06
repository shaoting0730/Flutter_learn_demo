import 'package:flutter/material.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('什么鸡毛都没有请求下来。。。'),
    );
  }
}
