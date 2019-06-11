import 'package:flutter/material.dart';
import '../../utils/trahslations.dart';

class TwoPage extends StatefulWidget {
  @override
  _TwoPageState createState() => _TwoPageState();
}

class _TwoPageState extends State<TwoPage> {
  String _lang(String key) {
    return Translations.of(context).text(key);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_lang("mine"))),
      body: Center(
        child: Text('........'),
      ),
    );
  }
}

