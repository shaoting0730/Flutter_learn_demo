import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo1/provider/color_provider.dart';
import 'package:provider_demo1/provider/counter_provider.dart';

class OnePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('One'),
      ),
      body: Consumer<CounterProvider>(
        builder: (context, model, child) {
          return ListView(
            children: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  model.addCounter();
                },
              ),
              Chip(
                backgroundColor: Provider.of<ColorProvider>(context).color,
                padding: EdgeInsets.all(12.0),
                label: Text(
                  model.count.toString(),
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  model.subCounter();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
