/*
 * @Author: shaoting0730 510738319@qq.com
 * @Date: 2024-08-02 16:35:52
 * @LastEditors: shaoting0730 510738319@qq.com
 * @LastEditTime: 2024-08-02 16:37:20
 * @FilePath: /ddd/lib/main.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'package:flutter/material.dart';
import './lottery_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '九宫格抽奖',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<LotteryEntity> list;

  @override
  void initState() {
    super.initState();
    list = [
      LotteryEntity('Airpods'),
      LotteryEntity('AirpodsPro'),
      LotteryEntity('机械键盘'),
      LotteryEntity('小爱同学'),
      LotteryEntity('iPad'),
      LotteryEntity('Mac'),
      LotteryEntity('天猫精灵'),
      LotteryEntity('iPhone 14'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('九宫格抽奖'),
      ),
      body: Center(
        child: SizedBox(
          height: 300,
          width: 300,
          child: LotteryWidget(list: list),
        ),
      ),
    );
  }
}
