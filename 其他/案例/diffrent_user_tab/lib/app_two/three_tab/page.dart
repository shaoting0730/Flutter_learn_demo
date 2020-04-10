import 'package:fish_redux/fish_redux.dart';

import './effect.dart';
import './reducer.dart';
import './state.dart';
import './view.dart';

import '../store/store.dart';
import '../store/update.dart';

class ThreePage extends Page<ThreeState, Map<String, dynamic>> {
  ThreePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ThreeState>(
              adapter: null, slots: <String, Dependent<ThreeState>>{}),
          middleware: <Middleware<ThreeState>>[],
        ) {
    connectExtraStore(GlobalStore.store, globalUpdate());
  }
}
