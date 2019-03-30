import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String paramsId;
  DetailsPage(this.paramsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: Center(
        child: Text(paramsId),
      ),
    );
  }
}
