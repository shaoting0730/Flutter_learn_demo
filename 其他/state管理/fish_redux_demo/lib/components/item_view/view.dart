import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

import '../../model/twoModel.dart';

Widget buildView(
    ItemViewState state, Dispatch dispatch, ViewService viewService) {
  List<Data> items = state.model.data;
  return ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) {
      return Container(
        padding: EdgeInsets.all(5.0),
        child: Row(
          children: <Widget>[
            Image.network(
              items[index].image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Text(
                items[index].title,
                maxLines: 4,
              ),
            ),
          ],
        ),
      );
    },
  );
}
