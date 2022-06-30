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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _offset = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DraggableDivider"),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          const dividerWidget = 16.0;
          const minWidth = 50.0;
          final halfWidth = constraints.maxWidth * 0.5;

          if (halfWidth + _offset < minWidth) {
            _offset = minWidth - halfWidth;
          } else if (halfWidth - _offset < minWidth) {
            _offset = halfWidth - minWidth;
          }

          return Row(
            children: [
              SizedBox(
                width: halfWidth + _offset - dividerWidget / 2,
                child: Container(
                  color: Colors.yellow,
                ),
              ),
              SizedBox(
                width: dividerWidget,
                child: DraggableDivider(
                  callBack: (double dx) {
                    setState(() {
                      _offset += dx;
                    });
                  },
                ),
              ),
              SizedBox(
                width: halfWidth - _offset - dividerWidget / 2,
                child: Container(
                  color: Colors.pink,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class DraggableDivider extends StatelessWidget {
  final Function(double dalta) callBack;
  const DraggableDivider({Key? key, required this.callBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        callBack(details.delta.dx);
      },
      child: const MouseRegion(
        cursor: SystemMouseCursors.resizeColumn,
        child: VerticalDivider(
          thickness: 4,
          color: Colors.green,
        ),
      ),
    );
  }
}
