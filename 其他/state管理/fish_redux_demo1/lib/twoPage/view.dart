import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(TwoState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      title: Text('two'),
    ),
    body: GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 20.0,
      mainAxisSpacing: 20.0,
      childAspectRatio: 1,
      children: List.generate(state.models.length, (index) {
        return Center(
          child: Card(
            color: Colors.lightBlueAccent,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(100),
              onTap: () {},
              child: Container(
                width: 200,
                height: 200,
                child: Center(
                  child: Text(state.models[index].name),
                ),
              ),
            ),
          ),
        );
      }),
    ),
  );
}
