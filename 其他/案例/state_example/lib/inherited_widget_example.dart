import 'package:flutter/material.dart';

class InheritedWidgetExample extends StatefulWidget {
  const InheritedWidgetExample({Key? key}) : super(key: key);

  @override
  State<InheritedWidgetExample> createState() => _InheritedWidgetExampleState();
}

class _InheritedWidgetExampleState extends State<InheritedWidgetExample> {
  Color _color = Colors.red;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('State'),
      ),
      body: Center(
        child: MyColor(
          color: _color,
          child: const Column(
            children: [
              SecondWidget(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.color_lens),
        onPressed: () {
          setState(() {
            _color = Colors.yellow;
          });
        },
      ), // This trailing comma
    );
  }
}

class MyColor extends InheritedWidget {
  final Color color;
  const MyColor({super.key, required this.color, required super.child});

  static MyColor? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyColor>();
  }

  static MyColor of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyColor>()!;
  }

  @override
  bool updateShouldNotify(covariant MyColor oldWidget) {
    return oldWidget.color != color;
  }
}

class SecondWidget extends StatelessWidget {
  const SecondWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: MyColor.of(context).color,
    );
  }
}
