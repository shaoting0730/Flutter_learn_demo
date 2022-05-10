import 'package:get/get.dart';
import '../pages/one_page/one_data_model.dart';

class ServiceProvider extends GetConnect {
  @override
  void onInit() {
    // httpClient.defaultDecoder = OneDataModel.listFromJson;
    httpClient.addResponseModifier((request, response) {
      request.headers['Authorization'] = 'Bearer sdfsdfgsdfsdsdf12345678';
      return request;
    });
  }

  Future<Response<OneDataModel>> getOneData() => get<OneDataModel>('https://nova.bitcambio.com.br/api/v3/public/getassets', decoder: (obj) => OneDataModel.fromJson(obj));

  Future<Response<OneDataModel>> postCity(body) => post<OneDataModel>('https://www.xxxx.com', body, decoder: (obj) => OneDataModel.fromJson(obj));
}
