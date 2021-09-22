import 'package:flutter/material.dart';

// 发布Activity成功页面
class PublishActivitySuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('发布成功'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(15, 60, 15, 60),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/icon_publish_success.png'),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text("发布商品成功",
                    style: TextStyle(fontSize: 14, color: Color(0xFF333333))),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: MaterialButton(
                    height: 44,
                    child: Text(
                      "发布成功",
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                    color: Color(0xFFFFAF4C),
                    onPressed: () => Navigator.pop(context)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Text('返回首页',
                    style: TextStyle(fontSize: 14, color: Color(0xFF999999))),
              )
            ]),
      ),
    );
  }
}
