import 'package:flutter/material.dart';

class ChangeNotifierExample extends StatefulWidget {
  const ChangeNotifierExample({Key? key}) : super(key: key);

  @override
  State<ChangeNotifierExample> createState() => _ChangeNotifierExampleState();
}

class _ChangeNotifierExampleState extends State<ChangeNotifierExample> {

  CounterController controller = CounterController();


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
              listenable: controller,
              builder: (BuildContext context, Widget? child) {
                return Text('${controller.count}');
              },
            ),
            ElevatedButton(
              onPressed: () {
                controller.reset();
              },
              child: const Text('清空'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          controller.count++;
        },
      ), // This trailing comma
    );
  }
}


/// 自定义controller
class CounterController extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  set count(value) {
    _count = value;
    notifyListeners();
  }

  void reset() {
    _count = 0;
    notifyListeners();
  }
}