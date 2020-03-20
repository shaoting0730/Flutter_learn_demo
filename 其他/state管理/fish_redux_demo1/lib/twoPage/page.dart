import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TwoPage extends Page<TwoState, Map<String, dynamic>> {
  TwoPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<TwoState>(
                adapter: null,
                slots: <String, Dependent<TwoState>>{
                }),
            middleware: <Middleware<TwoState>>[
            ],);

}
