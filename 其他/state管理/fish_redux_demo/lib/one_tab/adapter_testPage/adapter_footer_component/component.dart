import 'package:fish_redux/fish_redux.dart';

import 'view.dart';

class ListFooterComponent extends Component<String> {
  ListFooterComponent()
      : super(
          view: buildView,
          dependencies: Dependencies<String>(
              adapter: null, slots: <String, Dependent<String>>{}),
        );
}
