/*
* 高级搜索
* */

import 'package:flutter/material.dart';
import '../../models/api/tag.dart';

class AdvancedSearchPage extends StatefulWidget {
  final TagModel model; // tag 的数据

  AdvancedSearchPage({
    Key key,
    @required this.model,
  }) : super(key: key);
  @override
  _AdvancedSearchPageState createState() => _AdvancedSearchPageState();
}

class _AdvancedSearchPageState extends State<AdvancedSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('高级搜索'),
      ),
      body: ListView(
        children: <Widget>[],
      ),
    );
  }
}
