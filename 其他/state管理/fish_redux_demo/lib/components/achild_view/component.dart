import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AchildViewComponent extends Component<AchildViewState> {
  AchildViewComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<AchildViewState>(
                adapter: null,
                slots: <String, Dependent<AchildViewState>>{
                }),);

}
