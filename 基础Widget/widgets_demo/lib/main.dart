import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'top_barbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter_swiper/flutter_swiper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  /*
   *  获取本地化值
   */
  Future<int> get() async {
    int guide = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    guide = prefs.getInt('guide');
    return guide;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: get(),
        builder: (context, snapshot) {
          if (snapshot.data == 1) {
            return TopBar();
          } else {
            return GuidePage();
          }
        },
      ),
    );
  }
}

// 引导页面
class GuidePage extends StatefulWidget {
  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  SwiperController _controller;
  @override
  Widget build(BuildContext context) {
    List swiperDateList = ['guide1.jpg', 'guide2.jpg', 'guide3.jpg'];
    return Scaffold(
      body: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {},
              child: index < swiperDateList.length - 1
                  ? Image.asset(
                      'images/' + '${swiperDateList[index]}',
                      fit: BoxFit.cover,
                    )
                  : Container(
                      child: Stack(
                        alignment: const FractionalOffset(0.5, 0.8),
                        children: <Widget>[
                          Image.asset('images/guide3.jpg',
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              fit: BoxFit.cover),    
                          InkWell(
                            onTap: _endGuideView,
                            child: Text(
                              '开始体验',
                              style:
                                  TextStyle(color: Colors.red, fontSize: 20.0),
                            ),
                          )
                        ],
                      ),
                    ),
            );
          },
          itemCount: swiperDateList.length,
          pagination: SwiperPagination(),
          controller: _controller,
          autoplay: false,
          loop: false),
    );
  }
  /*
   * 结束浏览页面
   * 存标志位 跳转页面
   */
  _endGuideView() async {
    // 存标志
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('guide', 1);
    // 跳转页面
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MyApp()),
        (route) => route == null);
  }
}
