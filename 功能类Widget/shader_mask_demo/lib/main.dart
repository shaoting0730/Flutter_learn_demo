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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 文字ShaderMask
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: <Color>[
                    Colors.white,
                    Colors.red,
                  ],
                  begin: Alignment(-1, 0),
                  end: Alignment(-0.9, 0),
                  tileMode: TileMode.repeated,
                ).createShader(bounds);
              },
              child: const Text(
                '斑马效果',
                style: TextStyle(fontSize: 60, color: Colors.white),
              ),
            ),
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: <Color>[
                    Colors.yellow,
                    Colors.black,
                  ],
                  begin: Alignment(-1, 0),
                  end: Alignment(2, 0),
                  tileMode: TileMode.repeated,
                ).createShader(bounds);
              },
              child: const Text(
                '渐变',
                style: TextStyle(fontSize: 60, color: Colors.white),
              ),
            ),
            // logo ShaderMask
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return const RadialGradient(
                  colors: <Color>[
                    Colors.yellow,
                    Colors.red,
                    Colors.black,
                    Colors.blue,
                    Colors.orange,
                    Colors.pink,
                  ],
                ).createShader(bounds);
              },
              child: const FlutterLogo(
                size: 100,
              ),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
