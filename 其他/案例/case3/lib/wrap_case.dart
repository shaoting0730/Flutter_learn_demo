import 'package:flutter/material.dart';

class WrapCase extends StatefulWidget {
  _WrapCaseState createState() => _WrapCaseState();
}

class _WrapCaseState extends State<WrapCase> {
  List<Widget> imgList;

  @override
  void initState() {
    super.initState();
    imgList = List<Widget>()..add(buildAddButton());
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width; // 屏宽
    final height = MediaQuery.of(context).size.height; // 屏高

    return Scaffold(
      appBar: AppBar(title: Text('案例3')),
      body: Center(
        child: Opacity(
          opacity: 0.8,
          child: Container(
            width: width,
            height: height / 2,
            color: Colors.grey,
            child: Wrap(spacing: 25.0, children: imgList),
          ),
        ),
      ),
    );
  }

  Widget buildAddButton() {
    return GestureDetector(
      onTap: () {
        if (imgList.length < 9) {
          setState(() {
            imgList.insert(imgList.length - 1, buildPhoto());
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 100.0,
          height: 100.0,
          color: Colors.black54,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget buildPhoto() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 100.0,
        height: 100.0,
        color: Colors.yellow,
        child: Center(
          child: imgList.length % 2 == 0
              ? Image.network(
                  'https://ws1.sinaimg.cn/large/0065oQSqgy1fze94uew3jj30qo10cdka.jpg',
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.cover)
              : Image.network(
                  'https://ws1.sinaimg.cn/large/0065oQSqly1fv5n6daacqj30sg10f1dw.jpg',
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.cover),
        ),
      ),
    );
  }
}
