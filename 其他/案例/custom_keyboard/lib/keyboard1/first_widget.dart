import 'package:flutter/material.dart';

class FirstlyWidget extends StatefulWidget {
  final Function onResult;
  const FirstlyWidget({Key? key, required this.onResult}) : super(key: key);

  @override
  State<FirstlyWidget> createState() => _FirstlyWidgetState();
}

class _FirstlyWidgetState extends State<FirstlyWidget> {
  final List _list = [
    {'name': '官二代', 'level': '1'},
    {'name': '官二代', 'level': '2'},
    {'name': '官二代', 'level': '3'},
    {'name': '富二代', 'level': '1'},
    {'name': '富二代', 'level': '2'},
    {'name': '富二代', 'level': '3'},
    {'name': '拆二代', 'level': '1'},
    {'name': '拆二代', 'level': '2'},
    {'name': '拆二代', 'level': '3'},
    {'name': '随机', 'level': '-1'},
  ];
  Map _selectContent = {'name': '', 'level': ''};

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.transparent,
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "请选择您的出身:\n" + _selectContent.toString(),
              style: const TextStyle(fontSize: 25, color: Colors.yellow),
            ),
            Wrap(spacing: 2, runSpacing: 2, children: _list.map((e) => _item(e)).toList()),
          ],
        ),
      ),
    );
  }

  Widget _item(e) {
    return InkWell(
      onTap: () => _selectItem(e),
      child: Container(
        color: Colors.red,
        width: 80,
        height: 80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(e['name']),
            Text('等级' + e['level']),
          ],
        ),
      ),
    );
  }

  _selectItem(e) {
    setState(() {
      _selectContent = e;
    });
    widget.onResult(e);
  }
}
