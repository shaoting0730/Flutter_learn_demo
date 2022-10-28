import 'package:flutter/material.dart';
import 'package:fruit/utils/export_library.dart';
import 'package:fruit/pages/home_page/state/counter.dart';
import 'package:fruit/pages/mine_page/state/color.dart';

class MinePage extends ConsumerWidget {
  MinePage({Key? key}) : super(key: key);

  onClick() {
    eventBus.fire(
      NotIndex('3'),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).mineTitle!),
        centerTitle: true,
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
            InkWell(
              onTap: () => onClick(),
              child: const Text('改变'),
            )
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
