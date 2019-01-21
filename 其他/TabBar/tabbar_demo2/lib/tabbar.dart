import 'package:flutter/material.dart';
import 'package:tabbar_demo/each_view.dart';

class Tabbar extends StatefulWidget {
  _TabbarState createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  List<Widget> _eachView;
  int _index = 0;
  @override
  void initState() {
    super.initState();
    _eachView = List();
    _eachView..add(EachView('Home'))..add(EachView('Mine'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _eachView[_index],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
              return EachView('New');
            }),
          );
        },
        tooltip: 'tab',
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlue,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              color: _index == 0 ? Colors.red : Colors.white,
              onPressed: () {
                setState(() {
                  _index = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.ac_unit),
              color: _index == 1 ? Colors.red : Colors.white,
              onPressed: () {
                setState(() {
                  _index = 1;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
