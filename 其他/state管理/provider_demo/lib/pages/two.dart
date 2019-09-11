import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bloc/counter_bloc.dart';
import '../bloc/color_bloc.dart';

class Two extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Two'),
      ),
      body: Center(
        child: StreamBuilder(
          builder: (context, snapshot) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Provider.of<CounterBloc>(context).addCounter();
                    }),
                Chip(
                  backgroundColor: Provider.of<ColorDataBloc>(context).color,
                  padding: EdgeInsets.all(12.0),
                  label: Text(
                    Provider.of<CounterBloc>(context).count.toString(),
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      Provider.of<CounterBloc>(context).subCounter();
                    }),
              ],
            );
          },
          initialData: Provider.of<CounterBloc>(context).count,
          stream: Provider.of<CounterBloc>(context).stream,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<ColorDataBloc>(context).changeColor();
        },
        child: Icon(
          Icons.build,
          color: Colors.white,
        ),
      ),
    );
  }
}
