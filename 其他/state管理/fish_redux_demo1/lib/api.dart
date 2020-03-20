import 'model.dart';

class Api {
  factory Api() {
    return _get();
  }

  static Api _instance;

  Api._internal() {
    //init Api instance
  }

  static _get() {
    if (_instance == null) {
      _instance = Api._internal();
    }
    return _instance;
  }

  List<TwoGuidModel> getGridData() {
    return [
      TwoGuidModel(name: "第一块"),
      TwoGuidModel(name: "第二块"),
      TwoGuidModel(name: "第三块"),
      TwoGuidModel(name: "第四块"),
      TwoGuidModel(name: "第五块"),
      TwoGuidModel(name: "第六块"),
      TwoGuidModel(name: "第七块"),
      TwoGuidModel(name: "第八块"),
      TwoGuidModel(name: "第九块"),
      TwoGuidModel(name: "第十块"),
    ];
  }
}
