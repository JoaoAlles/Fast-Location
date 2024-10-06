import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

mixin AppDio {
  static Future<Dio> getConnection() async {
    final dio = Dio();

    dio.options = BaseOptions(
      connectTimeout: 15000,
      receiveTimeout: 30000,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _printRequestLog(options);
          return handler.next(options);
        },
        onResponse: (response, handler) {
          _printResponseLog(response);
          return handler.next(response);
        },
        onError: (error, handler) {
          _printErrorLog(error);
          return handler.next(error);
        },
      ),
    );

    return dio;
  }

  static void _printRequestLog(RequestOptions options) {
    debugPrint('-----------| Request log |-----------');
    debugPrint('${options.uri}');
  }

  static void _printResponseLog(Response response) {
    debugPrint('-----------| Response log |-----------');
    debugPrint(response.data.toString());
  }

  static void _printErrorLog(DioError error) {
    debugPrint('-----------| Error log |-----------');
    debugPrint('${error.response}');
  }
}
