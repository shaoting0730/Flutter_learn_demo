import 'package:flutter/material.dart';

class MoreList1 extends StatefulWidget {
  const MoreList1({Key? key}) : super(key: key);

  @override
  State<MoreList1> createState() => _MoreList1State();
}

class _MoreList1State extends State<MoreList1> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('1111111111111'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            for (var i = 0; i < 100; i++) const Item(),
          ]),
        ),
        Text('1111111111111'),
        Text('1111111111111'),
      ],
    );
  }
}

class Item extends StatelessWidget {
  const Item({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      color: Colors.red,
      width: 50,
      height: 50,
    );
  }
}
