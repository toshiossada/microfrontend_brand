import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';

class CustomInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    //Imprimindo informações do request para debug
    if (kDebugMode) {
      debugPrint(json.encode("BaseURL: ${options.baseUrl}"));
      debugPrint(json.encode("Endpoint: ${options.path}"));
      if (options.headers['access-token'] != null) {
        debugPrint("access-token: ${options.headers['access-token']}");
      }
      if (options.data != null) {
        debugPrint("Payload ${json.encode(options.data)}");
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      debugPrint("response: ${json.encode(response.data)}");
    }
    handler.next(response);
  }

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) {
    handler.next(err);
  }
}
