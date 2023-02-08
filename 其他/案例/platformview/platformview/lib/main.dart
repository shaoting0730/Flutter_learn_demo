import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';

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
        primarySwatch: Colors.blue,
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
        title: Text(widget.title),
      ),
      body: Platform.isIOS
          ? const UiKitView(
              viewType: "platform_text_view",
              creationParams: <String, dynamic>{"text": "iOS Label"},
              creationParamsCodec: StandardMessageCodec(),
            )
          : const AndroidView(
              viewType: "platform_text_view",
              creationParams: <String, dynamic>{"text": "Android Text View"},
              creationParamsCodec: StandardMessageCodec(),
            ),
    );
  }
}
