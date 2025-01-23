import 'package:flutter/material.dart';

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
  OverlayEntry? _overlayEntry;

  void showOverlay() {
    final entry = OverlayEntry(
      builder: (context) => Container(
        width: 200,
        height: 300,
        child: Center(
          child: GestureDetector(
            onTap: () {
              hideOverlay();
            },
            child: Container(
              width: 200,
              height: 300,
              color: Colors.red,
              alignment: Alignment.center,
              child: Text(
                '警告',
                style: TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(entry);
    _overlayEntry = entry;
  }

  void hideOverlay() {
    _overlayEntry?.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondPage()),
                );
              },
              child: Text(
                '跳',
                style: TextStyle(fontSize: 40),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showOverlay,
        tooltip: '弹出',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第二'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ThirdPage()),
              );
            },
            child: Text(
              '跳',
              style: TextStyle(fontSize: 40),
            ),
          ),
        ],
      ),
    );
  }
}

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第三'),
      ),
    );
  }
}
