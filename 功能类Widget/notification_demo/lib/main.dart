import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
      ),
      body: NotificationListener(
        // 监听通知
        onNotification: (notification) {
          if (notification is MyNotification) {
            print(notification.details);
            return true; // 是MyNotification,拦截
          } else {
            return false; // 不是MyNotification,不拦截
          }
        },
        child: const Sender(),
      ),
    );
  }
}

class Sender extends StatelessWidget {
  const Sender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            MyNotification('你好').dispatch(context);
          },
          child: const Text('发送字符串通知'),
        ),
        ElevatedButton(
          onPressed: () {
            MyNotification(Colors.red).dispatch(context);
          },
          child: const Text('发送字符串通知'),
        )
      ],
    );
  }
}

class MyNotification extends Notification {
  // 自定义通知内部变量，用于储存通知细节，类型为dynamic，即为任意类型
  late final dynamic details;
  MyNotification(this.details);
}
