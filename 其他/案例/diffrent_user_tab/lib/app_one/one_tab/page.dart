import 'package:fish_redux/fish_redux.dart';

import './effect.dart';
import './reducer.dart';
import './state.dart';
import './view.dart';

import '../store/store.dart';
import '../store/update.dart';

class OnePage extends Page<OneState, Map<String, dynamic>> {
  OnePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<OneState>(
              adapter: null, slots: <String, Dependent<OneState>>{}),
          middleware: <Middleware<OneState>>[],
        ) {
    connectExtraStore(GlobalStore.store, globalUpdate());
  }
}
