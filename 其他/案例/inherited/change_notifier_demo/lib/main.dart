import 'package:flutter/material.dart';
import 'change_notifier_provider.dart';
import 'count_model.dart';
import 'notify_consumer.dart';

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
      appBar: AppBar(title: const Text('Hello')),
      body: Center(
        child: ChangeNotifierProvider<CountModel>(
          data: CountModel(),
          child: Builder(
            builder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Builder(
                    builder: (context) {
                      //获取共享数据源
                      return NotifyConsumer<CountModel>(builder: (context, value) {
                        return Text(value.count.toString());
                      });
                    },
                  ),
                  Builder(builder: (context) {
                    return InkWell(
                      child: const Text('自增'),
                      onTap: () {
                        //获取共享model，进行数据自增操作
                        ChangeNotifierProvider.of<CountModel>(context).increase();
                      },
                    );
                  }),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
