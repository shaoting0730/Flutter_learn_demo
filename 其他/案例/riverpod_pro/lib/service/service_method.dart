import 'package:fruit/utils/export_library.dart';

class DioUtil {
  Dio dio = Dio();

  DioUtil() {
    dio.options.connectTimeout = 3000; // 连接超时
    dio.options.contentType = Headers.formUrlEncodedContentType; // 解决web端跨域问题
    //添加拦截器
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          return handler.next(response);
        },
        onError: (DioError error, ErrorInterceptorHandler handler) {
          return handler.next(error);
        },
      ),
    );
  }

// 获取数据
  Future get(url, {formData}) async {
    try {
      Response response;
      if (formData == null) {
        response = await dio.get(url);
      } else {
        response = await dio.get(url, queryParameters: formData);
      }
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('后端接口出现异常');
      }
    } catch (e) {
      return Log().logger.w(e);
    }
  }

  //
  Future post(url, {formData}) async {
    try {
      setStorage('', 'token值');
      dio.options.headers = {'Content-Type': 'application/json', 'token': 'token值'};
      Response response;
      if (formData == null) {
        response = await dio.post(url);
      } else {
        response = await dio.post(url, data: formData);
      }
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('后端接口出现异常');
      }
    } catch (e) {
      return Log().logger.w(e);
    }
  }
}
