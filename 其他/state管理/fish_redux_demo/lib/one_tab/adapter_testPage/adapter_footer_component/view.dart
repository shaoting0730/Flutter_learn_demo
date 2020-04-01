import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

Widget buildView(String state, Dispatch dispatch, ViewService viewService) {
  return Card(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    elevation: 10,
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
      child: Text(
        state,
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
    ),
  );
}
