import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ChildViewComponent extends Component<ChildViewState> {
  ChildViewComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ChildViewState>(
                adapter: null,
                slots: <String, Dependent<ChildViewState>>{
                }),);

}
