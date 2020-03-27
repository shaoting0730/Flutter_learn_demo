import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

import '../../model/twoModel.dart';

Widget buildView(
    ItemViewState state, Dispatch dispatch, ViewService viewService) {
  List<Data> items = state.model.data;
  List<Widget> widgets = [];
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
  return Column(children: widgets);
}
