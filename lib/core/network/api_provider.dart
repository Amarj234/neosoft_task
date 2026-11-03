import 'package:dio/dio.dart';

import '../const/api_url.dart';
import 'error_exception.dart';

class ApiProvider {
  ApiProvider._();

  static final dio = Dio(
    BaseOptions(

      baseUrl: baseUrl,
      responseType: ResponseType.json,
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
    ),
  )..interceptors.add(ErrorException());
}
