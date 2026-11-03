

import 'package:dio/dio.dart';

class ErrorException extends Interceptor{


  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    options.headers['Content-Type'] = 'application/json';

    super.onRequest(options, handler);
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {


    // TODO: implement onError
    super.onError(err, handler);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {

    if(response.statusCode==401){

    }

    // TODO: implement onResponse
    super.onResponse(response, handler);
  }
}