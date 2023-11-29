/*
 * @Author: zhoushaoting 510738319@qq.com
 * @Date: 2023-11-29 15:49:23
 * @LastEditors: zhoushaoting 510738319@qq.com
 * @LastEditTime: 2023-11-29 15:54:37
 * @FilePath: /restoration_id_demo/lib/main.dart
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
      restorationScopeId: 'app',
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
      home: const RestorableCounter(
        restorationId: 'counter',
      ),
    );
  }
}

class RestorableCounter extends StatefulWidget {
  const RestorableCounter({Key? key, this.restorationId}) : super(key: key);
  final String? restorationId;

  @override
  State<RestorableCounter> createState() => _RestorableCounterState();
}

class _RestorableCounterState extends State<RestorableCounter>
    with RestorationMixin {
  // 1. 混入 RestorationMixin

  // 3. 使用 RestorableInt 对象记录数值
  final RestorableInt _counter = RestorableInt(0);

  // 2. 覆写 restorationId 提供 id
  // @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    // 4. 注册 _counter
    registerForRestoration(_counter, 'count');
  }

  @override
  void dispose() {
    _counter.dispose(); // 5. 销毁
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restorable Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '${_counter.value}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter.value++;
    });
  }
}
