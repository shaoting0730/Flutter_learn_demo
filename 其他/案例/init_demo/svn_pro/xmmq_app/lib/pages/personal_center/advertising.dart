import 'package:flutter/material.dart';

class AdvertisingPage extends StatefulWidget {
  @override
  State<AdvertisingPage> createState() {
    return AdvertisingPageState();
  }
}

class AdvertisingPageState extends State<AdvertisingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('投放广告'),
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
          child: Column(children: <Widget>[_buildUploadPictureArea()]),
        ));
  }

  Widget _buildUploadPictureArea() {
    return Container(
        child: Row(
      children: <Widget>[],
    ));
  }
}
