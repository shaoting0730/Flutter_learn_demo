import 'package:flutter/material.dart';

class NetErrorWidget extends StatefulWidget {
  const NetErrorWidget({Key? key}) : super(key: key);

  @override
  State<NetErrorWidget> createState() => _NetErrorWidgetState();
}

class _NetErrorWidgetState extends State<NetErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('出错了'),
          Icon(Icons.phonelink_erase_rounded),
        ],
      ),
    );
  }
}
