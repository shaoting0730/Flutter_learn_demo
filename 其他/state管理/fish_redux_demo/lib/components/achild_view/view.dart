import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    AchildViewState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    child: InkWell(
      onTap: () {
        dispatch(AchildViewActionCreator.changeThemeColor());
      },
      child: Text('修改全局state'),
    ),
  );
}
