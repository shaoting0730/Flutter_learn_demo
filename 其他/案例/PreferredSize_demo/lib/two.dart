import 'package:flutter/material.dart';

class Two extends StatefulWidget {
  const Two({Key? key}) : super(key: key);

  @override
  _TwoState createState() => _TwoState();
}

class _TwoState extends State<Two> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Two'),
      ),
      body: Container(),
    );
  }
}
