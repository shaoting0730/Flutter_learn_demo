import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

import '../components/child_view/component.dart';
import '../components/achild_view/component.dart';

class OnePage extends Page<OneState, Map<String, dynamic>> {
  OnePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<OneState>(
              adapter: null,
              slots: <String, Dependent<OneState>>{
                'ChildViewComponent':
                    ChildViewConnector() + ChildViewComponent(),
                'AchildViewComponent':
                    AchildViewConnector() + AchildViewComponent(),
              }),
          middleware: <Middleware<OneState>>[],
        );
}
