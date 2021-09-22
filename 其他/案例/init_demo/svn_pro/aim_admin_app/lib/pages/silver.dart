import '../widgets/navigation_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Silver extends StatefulWidget {
  Silver({Key key}) : super(key: key);

  @override
  _SilverState createState() => new _SilverState();
}

class _SilverState extends State<Silver> {
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: NavigationHeader('个人中心'),
          pinned: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Text('TODO'),
            Padding(
              padding: EdgeInsets.only(bottom: 50),
            )
          ]),
        ),
      ],
    );
  }
}
