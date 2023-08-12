import 'package:flutter/material.dart';

class ValueNotifierExample extends StatefulWidget {
  const ValueNotifierExample({Key? key}) : super(key: key);

  @override
  State<ValueNotifierExample> createState() => _ValueNotifierExampleState();
}

class _ValueNotifierExampleState extends State<ValueNotifierExample> {
  final CounterController _controller = CounterController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('State'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListenableBuilder(
              listenable: Listenable.merge([
                _controller.count,
                _controller.fontSize,
              ]),
              builder: (BuildContext context, Widget? child) {
                return Text(
                  '${_controller.count.value}',
                  style: TextStyle(fontSize: _controller.fontSize.value),
                );
              },
            ),
            ElevatedButton(
                onPressed: () {
                  _controller.count.value++;
                },
                child: const Text('+1'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.zoom_in),
        onPressed: () {
          _controller.fontSize.value += 10.0;
        },
      ), // This trailing comma
    );
  }
}

class CounterController {
  ValueNotifier<int> count = ValueNotifier(0);
  ValueNotifier<double> fontSize = ValueNotifier(40);
}
