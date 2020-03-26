import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ItemViewComponent extends Component<ItemViewState> {
  ItemViewComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ItemViewState>(
                adapter: null,
                slots: <String, Dependent<ItemViewState>>{
                }),);

}
