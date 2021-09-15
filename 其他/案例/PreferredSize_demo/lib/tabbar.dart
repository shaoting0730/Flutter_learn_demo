import 'package:flutter/material.dart';
import 'package:sdf/one.dart';
import 'package:sdf/two.dart';

class MyTabBar extends StatefulWidget {
  const MyTabBar({Key? key}) : super(key: key);
  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  int _currenIndex = 0;

  final List<Widget> _list = [
    const One(),
    const Two(),
  ];

  itemOnclick(index) {
    setState(() {
      _currenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _list[_currenIndex],
      bottomNavigationBar: PreferredSize(
        preferredSize: const Size.fromHeight(69),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(width: 1, color: Color.fromRGBO(0, 0, 0, 0.1)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => itemOnclick(0),
                  child: SizedBox(
                    height: 69.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.ac_unit,
                          color: _currenIndex == 0 ? Colors.blue : Colors.black,
                        ),
                        Text(
                          '首页',
                          style: TextStyle(
                            color:
                                _currenIndex == 0 ? Colors.blue : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    // color: Colors.blue,
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => itemOnclick(1),
                  child: Container(
                    height: 69.0,
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: const FractionalOffset(2, 0.1),
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home,
                              color: _currenIndex == 1
                                  ? Colors.blue
                                  : Colors.black,
                            ),
                            Text(
                              '我的',
                              style: TextStyle(
                                color: _currenIndex == 1
                                    ? Colors.blue
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          width: 20,
                          height: 15,
                          child: const Center(
                            child: Text('2'),
                          ),
                        ),
                      ],
                    ),
                    // color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
