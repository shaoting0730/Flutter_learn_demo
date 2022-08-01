import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/rstate/counter.dart';
import 'package:riverpod_demo/rstate/color.dart';

class TwoPage extends ConsumerWidget {
  const TwoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('二'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                ref.read(counterProvider.notifier).addCounter();
                ref.read(colorProvider.notifier).changeColor();
              },
              child: const Text(
                '+',
                style: TextStyle(fontSize: 40),
              ),
            ),
            const _ColorfulCounterText(),
            InkWell(
              onTap: () {
                ref.read(counterProvider.notifier).subCounter();
                ref.read(colorProvider.notifier).changeColor();
              },
              child: const Text(
                '-',
                style: TextStyle(fontSize: 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorfulCounterText extends ConsumerWidget {
  const _ColorfulCounterText();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    final color = ref.watch(colorProvider);

    return Text(
      '$counter',
      style: TextStyle(
        color: color,
      ),
    );
  }
}
