import 'package:flutter/material.dart';

class EmptyDataWidget extends StatefulWidget {
  const EmptyDataWidget({Key? key}) : super(key: key);

  @override
  State<EmptyDataWidget> createState() => _EmptyDataWidgetState();
}

class _EmptyDataWidgetState extends State<EmptyDataWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('没有数据'),
          Icon(Icons.hourglass_empty),
        ],
      ),
    );
  }
}
