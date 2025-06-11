import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class ApplicationApiService {
  var dio = Dio();
  ApplicationApiService() {
    dio.options.baseUrl = 'http://10.10.4.100:4001/';
  }

  FutureOr<dynamic> getRequest({String baseUrl="/"}) async {
    var record = await dio.get(baseUrl);
    
    return record.data;
  }

}
