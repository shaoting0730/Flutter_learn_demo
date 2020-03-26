import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class OneDetailsPagePage extends Page<OneDetailsPageState, Map<String, dynamic>> {
  OneDetailsPagePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<OneDetailsPageState>(
                adapter: null,
                slots: <String, Dependent<OneDetailsPageState>>{
                }),
            middleware: <Middleware<OneDetailsPageState>>[
            ],);

}
