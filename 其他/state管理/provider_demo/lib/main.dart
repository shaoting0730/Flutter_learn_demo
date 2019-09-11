import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bloc/counter_bloc.dart';
import 'bloc/color_bloc.dart';

import './tabbar.dart';

main() {
  var counterBloc = CounterBloc();
  var colorDataBloc = ColorDataBloc();
  runApp(MultiProvider(providers: [
    Provider<ColorDataBloc>.value(value: colorDataBloc),
    Provider<CounterBloc>.value(value: counterBloc),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        return MaterialApp(
          home: Tabbar(),
        );
      },
      initialData: Provider.of<ColorDataBloc>(context).color,
      stream: Provider.of<ColorDataBloc>(context).stream,
    );
  }
}
