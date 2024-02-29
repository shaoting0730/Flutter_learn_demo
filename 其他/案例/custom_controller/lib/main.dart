/*
 * @Author: zhoushaoting 510738319@qq.com
 * @Date: 2024-02-29 10:00:28
 * @LastEditors: zhoushaoting 510738319@qq.com
 * @LastEditTime: 2024-02-29 13:02:42
 * @FilePath: /im_demo/lib/main.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
import 'dart:math';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   final CustomContainerController _cardController = CustomContainerController();
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          InkWell(
            onTap: (){
               _cardController.width.value += 5;
               _cardController.height.value += 10;
               // 随机数
               int r = Random().nextInt(256);
               int g = Random().nextInt(256);
               int b = Random().nextInt(256);
               _cardController.color.value = Color.fromRGBO(r, g, b, 1);
               _cardController.text.value = '$r, $g, $b';
            },
            child: Container(
              color: Colors.blue,
              height: 100,
              child: const Center(
                child: Text('修改'),
              ),  
            )
          ),
          // 
          CustomContainer(controller: _cardController,)
        ],
      )
    );
  }
}

class CustomContainer extends StatelessWidget {
  CustomContainer({super.key, required this.controller});
  CustomContainerController controller = CustomContainerController();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([controller.width, controller.color, controller.text]),
      builder: (BuildContext context, Widget? child) {
        return Container(
          width: controller.width.value,
          height: controller.height.value,
          color: controller.color.value,
          alignment: Alignment.center,
          child: Text(controller.text.value),
        );
      },
    );
  }
}

class CustomContainerController {

  ValueNotifier<double> width = ValueNotifier(100);
  ValueNotifier<double> height = ValueNotifier(100);
  ValueNotifier<Color> color = ValueNotifier(Colors.red);
  ValueNotifier<String> text = ValueNotifier('默认值');
}
