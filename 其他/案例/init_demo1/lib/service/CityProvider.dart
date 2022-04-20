import 'package:get/get.dart';

import '../pages/one_page/one_data_model.dart';

class OneProvider extends GetConnect {
  @override
  void onInit() {
    // All request will pass to jsonEncode so CasesModel.fromJson()
    httpClient.defaultDecoder = OneDataModel.listFromJson;
    httpClient.addResponseModifier((request, response) {
      request.headers['Authorization'] = 'Bearer sdfsdfgsdfsdsdf12345678';
      return request;
    });
  }

  Future<Response<List<OneDataModel>>> getCity() => get<List<OneDataModel>>('https://servicodados.ibge.gov.br/api/v1/localidades/estados');

  Future<Response<OneDataModel>> postCity(body) => post<OneDataModel>('http://192.168.0.101:3000/items', body, decoder: (obj) => OneDataModel.fromJson(obj));
}
