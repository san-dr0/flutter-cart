import 'dart:developer';

import 'package:clean_arch2/config/api-dio/generic.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class ApplicationApiService {
  var dio = Dio();
  ApplicationApiService() {
    dio.options.baseUrl = 'http://10.10.4.100:4000/';
  }

  FutureOr<GenericModel> getRequest({String baseUrl="/"}) async {
    var response = await dio.get(baseUrl);
    
    GenericModel genericModel = GenericModel.factory(response.data);
    return genericModel;
  }

  FutureOr<GenericModel> postRequest({String baseUrl = "/", required Map<String, dynamic> data}) async {
    var response = await dio.post(baseUrl, data: data, options: Options(
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      }
    ));
    GenericModel genericModel = GenericModel.factory(response.data);

    return genericModel;
  }

}
