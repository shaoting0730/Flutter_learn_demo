import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
import 'adapter_cell_component/component.dart';
import 'adapter_footer_component/component.dart';
import 'adapter_header_component/component.dart';

class ListGroupAdapter extends DynamicFlowAdapter<AdapterTestState> {
  ListGroupAdapter()
      : super(pool: <String, Component<Object>>{
          'header': ListHeaderComponent(),
          'cell': ListCellComponent(),
          'footer': ListFooterComponent()
        }, connector: ListGroupConnector());
}

class ListGroupConnector extends ConnOp<AdapterTestState, List<ItemBean>> {
  @override
  List<ItemBean> get(AdapterTestState state) {
    List<ItemBean> items = [];
    if (state.cellModels.length == 0) {
      return items;
    }
    items.add(ItemBean('header', state.headerModel));
    for (var cellModel in state.cellModels) {
      items.add(ItemBean('cell', cellModel));
    }
    items.add(ItemBean('footer', state.footerStr));
    return items;
  }
}
