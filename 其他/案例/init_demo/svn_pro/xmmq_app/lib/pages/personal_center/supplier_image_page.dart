/*
* 线上供应商-产品图片
* */

import 'package:flutter/material.dart';

class SupplierImagePage extends StatefulWidget {
  final String imgStr;
  SupplierImagePage({Key key, @required this.imgStr}) : super(key: key);
  @override
  _SupplierImagePageState createState() => _SupplierImagePageState();
}

class _SupplierImagePageState extends State<SupplierImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Image.network(
              widget.imgStr,
              fit: BoxFit.fitWidth,
            ),
          ],
        ),
      ),
    );
  }
}
