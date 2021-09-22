import 'package:flutter/material.dart';


class EmptyRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          SizedBox(height: 86,),
          Image.asset('assets/icon_record_empty.png'),
          SizedBox(height: 10,),
          Text('Empty', style: TextStyle(fontSize: 14, color: Color(0xFF536282)),)
        ],
      ),
    );
  }

}
