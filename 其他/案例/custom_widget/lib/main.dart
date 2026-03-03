/*
 * @Author: shaoting0730 510738319@qq.com
 * @Date: 2025-12-18 16:12:00
 * @LastEditors: shaoting0730 510738319@qq.com
 * @LastEditTime: 2025-12-18 17:59:33
 * @FilePath: /custom_widget/lib/main.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:custom_widget/cloud/cloud_demo_page.dart';
import 'package:custom_widget/custom_indicator.dart';
import 'package:custom_widget/custom_multi_render_demo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late ui.Image images;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _getImageData();
  }

  Future<void> _getImageData() async {
    images = await _getAssetImage();
    setState(() {});
  }

  Future<ui.Image> _getAssetImage() async {
    ByteData data = await rootBundle.load('assets/images/tabbar_Indicator.webp');
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: 40, targetHeight: 4);
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottom: TabBar(
          dividerColor: Colors.transparent,
          controller: _tabController,
          labelColor: Colors.red,
          unselectedLabelColor: Colors.blue,
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          indicator: UnderlineDecoration(color: Colors.white, length: 10, thickness: 4, image: images),
          tabs: [
            Tab(text: 'CustomMultiRenderDemoPage'),
            Tab(text: 'CloudDemoPage'),
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: [CustomMultiRenderDemoPage(), CloudDemoPage()]),
    );
  }
}
