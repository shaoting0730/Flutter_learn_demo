import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import '../state.dart';

Widget buildView(
    AdapterHeaderModel state, Dispatch dispatch, ViewService viewService) {
  return Column(
    children: <Widget>[
      Image.network(
        state.imageNamed,
        height: 300,
        width: MediaQuery.of(viewService.context).size.width,
        fit: BoxFit.cover,
      ),
      Text(
        state.title,
        style: TextStyle(color: Colors.black),
      ),
      Text(
        state.detailTitle,
        style: TextStyle(color: Colors.black45),
      ),
    ],
  );
}
