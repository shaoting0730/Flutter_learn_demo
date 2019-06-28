import 'package:flutter/material.dart';

class AppbarWidget extends StatefulWidget {
  @override
  _AppbarWidgetState createState() => _AppbarWidgetState();
}

class _AppbarWidgetState extends State<AppbarWidget> {
  // 返回每个隐藏的菜单项
  selectView(IconData icon, String text, String id) {
    return new PopupMenuItem<String>(
      value: id,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Icon(icon, color: Colors.red),
          new Text(text),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Text('首页'),
          leading: new Icon(Icons.home),
          backgroundColor: Colors.red,
          centerTitle: true,
          actions: <Widget>[
            // 非隐藏的菜单
            new IconButton(
                icon: new Icon(Icons.add_alarm),
                tooltip: 'Add Alarm',
                onPressed: () async {
                   showMenu(
                      context: context,
                      position:
                          RelativeRect.fromLTRB(100.0, 200.0, 100.0, 100.0),
                      items: <PopupMenuItem<String>>[
                        new PopupMenuItem<String>(
                            value: 'value01', child: new Text('Item One')),
                        new PopupMenuItem<String>(
                            value: 'value02', child: new Text('Item Two')),
                        new PopupMenuItem<String>(
                            value: 'value03', child: new Text('Item Three')),
                        new PopupMenuItem<String>(
                            value: 'value04', child: new Text('I am Item Four'))
                      ],);
                },),
            // 隐藏的菜单
            new PopupMenuButton<String>(
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                    this.selectView(Icons.message, '发起群聊', 'A'),
                    this.selectView(Icons.group_add, '添加服务', 'B'),
                    this.selectView(Icons.cast_connected, '扫一扫码', 'C'),
                  ],
              onSelected: (String action) {
                // 点击选项的时候
                switch (action) {
                  case 'A':
                    break;
                  case 'B':
                    break;
                  case 'C':
                    break;
                }
              },
            ),
          ],
        ),
        body: Text('AppBar演示'));
  }
}
