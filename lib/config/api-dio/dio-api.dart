import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class ApplicationApiService {
  var dio = Dio();
  ApplicationApiService() {
    dio.options.baseUrl = 'http://10.10.4.100:4001/';
  }

  FutureOr<dynamic> getRequest({String baseUrl="/"}) async {
    var response = await dio.get(baseUrl);
    
    return response.data;
  }

  FutureOr<dynamic> postRequest({String baseUrl = "/", required Map<String, dynamic> data}) async {
    var response = await dio.post(baseUrl, data: data, options: Options(
      headers: {
        "Content-Type": "application/json"
      }
    ));

    return response.data;
  }

}
