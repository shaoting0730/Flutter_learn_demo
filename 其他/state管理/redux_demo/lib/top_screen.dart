import 'package:flutter/material.dart';
import 'package:redux_demo/tabbar.dart';

class TopScreen extends StatefulWidget {
  @override
  _TopScreenState createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  @override
  Widget build(BuildContext context) {
    return Tabbar();
  }
}
