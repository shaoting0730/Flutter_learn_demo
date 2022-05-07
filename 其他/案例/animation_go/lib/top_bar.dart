import 'package:animation_go/animations/count_down_widget.dart';
import 'package:animation_go/animations/cu_lottie_widget.dart';
import 'package:animation_go/animations/cu_svgaplayer_widget.dart';
import 'package:animation_go/animations/hero_widget.dart';
import 'package:flutter/material.dart';
import 'package:animation_go/animations/slide_verify_widget.dart';

import 'animations/mqtt_widget.dart';
import 'animations/power_steering_widget.dart';

class Topbar extends StatefulWidget {
  const Topbar({Key? key}) : super(key: key);

  @override
  _TopbarState createState() => _TopbarState();
}

class _TopbarState extends State<Topbar> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 7, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _controller,
          isScrollable: true,
          tabs: [
            Tab(text: '滑动解锁'),
            Tab(text: 'AnimatedSwitcher'),
            Tab(text: 'Lottie动画'),
            Tab(text: 'SVGAPlayer动画'),
            Tab(text: 'MQTT通讯'),
            Tab(text: '手柄控制'),
            Tab(text: 'hero动画'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          Row(
            children: [
              SlideVerifyWidget(
                verifySuccessListener: () {},
              ),
            ],
          ),
          CountDownWidget(),
          CuLottieWidget(),
          CuSVGAPlayerWidget(),
          MqttDemo(),
          PowerSteeringDemo(),
          HeroWidget(),
        ],
      ),
    );
  }
}
