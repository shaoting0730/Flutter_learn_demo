import 'package:fish_redux/fish_redux.dart';

import './effect.dart';
import './reducer.dart';
import './state.dart';
import './view.dart';

class UserOneTabbarPage extends Page<TabbarState, Map<String, dynamic>> {
  UserOneTabbarPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<TabbarState>(
              adapter: null, slots: <String, Dependent<TabbarState>>{}),
          middleware: <Middleware<TabbarState>>[],
        );
}
