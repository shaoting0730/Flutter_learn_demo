import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

import '../../model/twoModel.dart';

Widget buildView(
    ItemViewState state, Dispatch dispatch, ViewService viewService) {
  List<Data> items = state.model.data;
  List<Widget> widgets = [];
  if (items.length > 0) {
    items.forEach((e) {
      widgets.add(
        Row(
          children: <Widget>[
            Image.network(
              e.image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Text(
                e.title,
                maxLines: 4,
              ),
            ),
          ],
        ),
      );
    });
  } else {
    widgets.add(
      Text('无数据'),
    );
  }

  return Column(children: widgets);
}
