import 'package:flutter/material.dart';
import 'package:riverpod_demo/rstate/counter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnePage extends ConsumerWidget {
  const OnePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('一'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                ref.read(counterProvider.notifier).addCounter();
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
    return Text(
      '$counter',
    );
  }
}
