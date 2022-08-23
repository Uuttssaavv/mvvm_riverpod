import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiServiceProvider = Provider((ref) => ApiService());

class ApiService {
  String authToken = '';

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com',
      receiveDataWhenStatusError: true,
      validateStatus: (value) {
        return value! <= 500;
      },
      headers: {
        'Accept': 'application/json',
      },
    ),
  )
    ..interceptors.add(
      LogInterceptor(
        requestBody: kDebugMode ? true : false,
        responseBody: kDebugMode ? true : false,
        requestHeader: kDebugMode ? true : false,
      ),
    )
    ..interceptors.add(
      InterceptorsWrapper(
        onError: (DioError e, handler) {
          if (e.response?.statusCode == 402) {
            //logout user and go to login page
          }
          return handler.next(e);
        },
      ),
    );
  void setToken(String token) {
    authToken = token;
    dio.options.headers['authorization'] = token;
  }
}
