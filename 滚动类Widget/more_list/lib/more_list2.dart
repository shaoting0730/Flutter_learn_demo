import 'package:flutter/material.dart';

class MoreList2 extends StatefulWidget {
  const MoreList2({Key? key}) : super(key: key);

  @override
  State<MoreList2> createState() => _MoreList2State();
}

class _MoreList2State extends State<MoreList2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('1111111111111'),
        Stack(
          children: [
            const IgnorePointer(
              child: Opacity(
                opacity: 0.0,
                child: Item(),
              ),
            ),
            const SizedBox(
              width: double.infinity,
            ),
            Positioned.fill(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return const Item();
                },
              ),
            )
          ],
        ),
        Text('111111221111111'),
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
