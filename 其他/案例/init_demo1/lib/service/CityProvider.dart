import 'package:get/get.dart';
import '../pages/one_page/one_data_model.dart';

class OneProvider extends GetConnect {
  @override
  void onInit() {
    // httpClient.defaultDecoder = OneDataModel.listFromJson;
    httpClient.addResponseModifier((request, response) {
      request.headers['Authorization'] = 'Bearer sdfsdfgsdfsdsdf12345678';
      return request;
    });
  }

  Future<Response<OneDataModel>> getCity() => get<OneDataModel>('https://www.mxnzp.com/api/history/today?type=1&app_id=iaurmulvtgtwreko&app_secret=clhxYnVpaUxuMUNOR3k3SzN6TmRNUT09', decoder: (obj) => OneDataModel.fromJson(obj));

  Future<Response<OneDataModel>> postCity(body) => post<OneDataModel>('http://192.168.0.101:3000/items', body, decoder: (obj) => OneDataModel.fromJson(obj));
}
