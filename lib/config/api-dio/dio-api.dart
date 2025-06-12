import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class ApplicationApiService {
  var dio = Dio();
  ApplicationApiService() {
    dio.options.baseUrl = 'http://192.168.64.134:4000/';
  }

  FutureOr<dynamic> getRequest({String baseUrl="/"}) async {
    var response = await dio.get(baseUrl);
    
    return response.data;
  }

  FutureOr<dynamic> postRequest({String baseUrl = "/", required Map<String, dynamic> data}) async {
    var response = await dio.post(baseUrl, data: data, options: Options(
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      }
    ));

    return response.data;
  }

}
