import 'package:flutter/material.dart';

class AddCount extends StatefulWidget {
  _AddCountState createState() => _AddCountState();
}

class _AddCountState extends State<AddCount>
    with AutomaticKeepAliveClientMixin {
  int _count = 0;

  @override
  bool get wantKeepAlive => true;

  void _addCount() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Text('点击加1'),
             Text(
               '$_count',
               style: Theme.of(context).textTheme.display1,
             )
           ],
         ),
       ), 
       floatingActionButton:FloatingActionButton(
         onPressed: _addCount,
         tooltip: '加',
         child: Icon(Icons.add),
       ),
    );
  }
}
