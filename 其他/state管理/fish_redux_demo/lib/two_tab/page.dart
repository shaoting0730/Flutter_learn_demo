import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

import '../components/item_view/component.dart';

import '../store/store.dart';
import '../store/update.dart';

class TwoPage extends Page<TwoState, Map<String, dynamic>> {
  TwoPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<TwoState>(
              slots: <String, Dependent<TwoState>>{
                'ChildViewComponent': ItemViewConnector() + ItemViewComponent()
              }),
        ) {
    connectExtraStore(GlobalStore.store, globalUpdate());
  }
}
