import 'package:fish_redux/fish_redux.dart';

import 'view.dart';
import '../state.dart';

class ListHeaderComponent extends Component<AdapterHeaderModel> {
  ListHeaderComponent()
      : super(
          view: buildView,
          dependencies: Dependencies<AdapterHeaderModel>(
              adapter: null, slots: <String, Dependent<AdapterHeaderModel>>{}),
        );
}
