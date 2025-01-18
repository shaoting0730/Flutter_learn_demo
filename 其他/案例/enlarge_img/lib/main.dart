/*
 * @Author: shaoting0730 510738319@qq.com
 * @Date: 2025-01-17 16:45:16
 * @LastEditors: shaoting0730 510738319@qq.com
 * @LastEditTime: 2025-01-18 10:24:41
 * @FilePath: /enlarge_img/lib/main.dart
 * @Description: 下拉图片放大   
 */
import 'package:flutter/material.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ZoomableListView(),
    );
  }
}

class ZoomableListView extends StatefulWidget {
  const ZoomableListView({super.key});

  @override
  State<ZoomableListView> createState() => _ZoomableListViewState();
}

class _ZoomableListViewState extends State<ZoomableListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(), // 添加弹性滚动效果
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            stretch: true, // 启用拉伸效果
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return FlexibleSpaceBar(
                  // title: const Text(
                  //   '下拉放大',
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 16.0,
                  //   ),
                  // ),
                  stretchModes: const [
                    // 添加拉伸模式
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                  ],
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        'https://picsum.photos/800/600', // 使用示例图片
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text('Item #$index'),
                );
              },
              childCount: 50,
            ),
          ),
        ],
      ),
    );
  }
}
