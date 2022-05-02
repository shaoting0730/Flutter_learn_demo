import 'package:flutter/material.dart';

import 'keyboard/view_keyboard.dart';
import 'keyboard1/first_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义键盘'),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () => _showKeyboard(),
            child: const Text("支付"),
          ),
          InkWell(
            onTap: () => _showKeyboard1(),
            child: const Text("自定义键盘1"),
          ),
        ],
      ),
    );
  }

  void _showKeyboard() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (builder) {
        return CustomKeyboard(
          keyHeight: 46,
          autoBack: false,
          pwdLength: 6,
          onKeyDown: (keyEvent) {
            if (keyEvent.isClose()) {
              Navigator.pop(context);
            }
          },
          onResult: (data) {
            print(data);
          },
        );
      },
    );
  }

  _showKeyboard1() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (builder) {
        return FirstlyWidget(
          onResult: (e) {
            print(e);
          },
        );
      },
    );
  }
}
