import 'package:fish_redux/fish_redux.dart';

import 'view.dart';
import '../state.dart';

class ListCellComponent extends Component<AdapterCellModel> {
  ListCellComponent()
      : super(
          view: buildView,
          dependencies: Dependencies<AdapterCellModel>(
              adapter: null, slots: <String, Dependent<AdapterCellModel>>{}),
        );
}
