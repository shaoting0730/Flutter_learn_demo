import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';
import '../../store/state.dart';

class AdapterTestState implements Cloneable<AdapterTestState>, GlobalBaseState {
  int num;
  @override
  Color themeColor;

  AdapterHeaderModel headerModel;
  List<AdapterCellModel> cellModels;
  String footerStr;

  AdapterTestState({this.headerModel, this.cellModels, this.footerStr});
  @override
  AdapterTestState clone() {
    return AdapterTestState()
      ..headerModel = headerModel
      ..cellModels = cellModels
      ..footerStr = footerStr
      ..num = num;
  }
}

AdapterTestState initState(Map<String, dynamic> args) {
  AdapterTestState state = AdapterTestState();
  final String headerImageNamed =
      'https://ae01.alicdn.com/kf/U55d86c21f8e3434280ff6aacef96a23aj.jpg';
  final String cellImageNamed =
      'https://ae01.alicdn.com/kf/U11829fe9d4ae4d96b053dbf1b1cc7382g.jpg';
  state.headerModel = AdapterHeaderModel(
      title: '测试数据头', imageNamed: headerImageNamed, detailTitle: '展示头部视图的标题使用');
  final List<AdapterCellModel> li = List<AdapterCellModel>.generate(
      20,
      (i) => AdapterCellModel(
          title: '萌妹子 ${i + 1}',
          imageNamed: cellImageNamed,
          detailTitle: '其实是男孩 ${i + 1}',
          dateStr: '我是描述描述描述'));
  state.cellModels = li;
  state.footerStr = '我是当前界面的区尾';
  state..num = args["params"]; // 前面界面传过来的参数
  return state;
}

class AdapterHeaderModel {
  String title;
  String imageNamed;
  String detailTitle;

  AdapterHeaderModel({this.title, this.imageNamed, this.detailTitle});
}

class AdapterCellModel {
  String title;
  String imageNamed;
  String detailTitle;
  String dateStr;

  AdapterCellModel(
      {this.title, this.imageNamed, this.detailTitle, this.dateStr});
}
