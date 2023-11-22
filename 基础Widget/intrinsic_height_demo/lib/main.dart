/*
 * @Author: zhoushaoting 510738319@qq.com
 * @Date: 2023-11-22 13:51:22
 * @LastEditors: zhoushaoting 510738319@qq.com
 * @LastEditTime: 2023-11-22 14:05:33
 * @FilePath: /intrinsic_height_demo/lib/main.dart
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
          children: [
            ///  IntrinsicHeight
            IntrinsicHeight(
              child: Row(
                children: [
                  Container(width: 20, color: Colors.red),
                  Column(
                    children: [
                      Container(width: 80, height: 20, color: Colors.blue),
                      Container(height: 40, width: 80, color: Colors.yellow),
                      Container(height: 50, width: 80, color: Colors.green),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 50,),
            //  IntrinsicWidth
            IntrinsicWidth(
              child: Column(
                children: [
                  Container(height: 20, color: Colors.red),
                  Row(
                    children: [
                      Container(width: 20, height: 20, color: Colors.blue),
                      Container(height: 40, width: 80, color: Colors.yellow),
                      Container(height: 10, width: 80, color: Colors.green),
                      Container(width: 20, height: 20, color: Colors.blue),
                      Container(height: 10, width: 80, color: Colors.green),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
    );
  }
}
