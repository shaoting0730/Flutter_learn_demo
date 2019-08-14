import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class Animation6 extends StatefulWidget {
  @override
  _Animation6State createState() => _Animation6State();
}

class _Animation6State extends State<Animation6>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  List _list = [
    "第一项",
    "第二项",
    "第三项",
    "第四项",
    "第五项",
    "第六项",
    "第七项",
    "第八项",
    "第九项",
    "第十项",
    "第十一项",
    "第十二项"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
  }

  /*
  * 下拉项
  * */
  Widget _pullDownWidget() {
    List<Widget> listWidget = _list.map((e) {
      return InkWell(
        onTap: () {
          _itemOnClick(e);
        },
        child: Text(e.toString()),
      );
    }).toList();
    return Center(
      child: ListView(
        children: listWidget,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            FlatButton(
              onPressed: () {
                if (animation.status == AnimationStatus.completed) {
                  controller.reverse();
                } else {
                  controller.forward();
                }
              },
              child: Text('点击'),
            ),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
            Text('主体内容'),
          ],
        ),
        Container(
          color: Colors.amberAccent,
          margin: new EdgeInsets.symmetric(vertical: 40.0),
          height: animation.value,
          width: MediaQuery.of(context).size.width,
          child: _pullDownWidget(),
        ),
      ],
    );
  }

  _itemOnClick(e) {
    print(e);
    controller.reverse();
  }
}
