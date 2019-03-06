
import 'package:flutter/material.dart';
import 'package:flutter_bloc_demo/bloc/counter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'tabbar.dart';

class TopScreen extends StatefulWidget {
  @override
  _TopScreenState createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
    final CounterBloc _counterBloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BlocProvider<CounterBloc>(
        bloc: _counterBloc,
        child: Tabbar(),
      ),
    );
  }
}