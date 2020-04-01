import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';
import 'adapter.dart';

class AdapterTestPage extends Page<AdapterTestState, Map<String, dynamic>> {
  AdapterTestPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<AdapterTestState>(
              adapter: NoneConn<AdapterTestState>() + ListGroupAdapter(),
              slots: <String, Dependent<AdapterTestState>>{}),
          middleware: <Middleware<AdapterTestState>>[],
        );
}
