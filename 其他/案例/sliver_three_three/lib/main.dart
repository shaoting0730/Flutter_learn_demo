/*
 * @Author: zhoushaoting 510738319@qq.com
 * @Date: 2023-10-30 17:42:40
 * @LastEditors: zhoushaoting 510738319@qq.com
 * @LastEditTime: 2023-10-31 11:17:19
 * @FilePath: /sliver_three_three/lib/main.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import 'package:sliver_three_three/sliver_tip/decorated_sliver_tip.dart';
import 'package:sliver_three_three/sliver_tip/sliver_constrained_cross_axis_tip.dart';
import 'package:sliver_three_three/sliver_tip/sliver_main_axis_group_tip.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SliverMainAxisGroupTip(),
                ),
              );
            },
            child: const Text(
              'SliverMainAxisGroup',
              style: TextStyle(color: Colors.red),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DecoratedSliverTip(),
                ),
              );
            },
            child: const Text(
              'DecoratedSliver',
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SliverConstrainedCorssAxisTip(),
                ),
              );
            },
            child: const Text(
              'SliverConstrainedCrossAxis 和 SliverCrossAxisExpanded 和 SliverCrossAxisGroup',
              style: TextStyle(color: Colors.red),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
