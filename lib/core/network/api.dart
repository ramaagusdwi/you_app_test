import 'package:dio/dio.dart';
import 'package:flutter_you_app/core/constant/api_path_constant.dart';

class Api {
  final dio = createDio();
  final tokenDio = Dio(BaseOptions(baseUrl: ApiPathConstants.baseUrl));

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      headers: {'Content-Type': 'application/json'},
      baseUrl: ApiPathConstants.baseUrl,
      receiveTimeout: Duration(seconds: 15000), // 15 seconds
      connectTimeout: Duration(seconds: 15000),
      sendTimeout: Duration(seconds: 15000),
      validateStatus: (status) {
        return status! < 500;
      },
    ));

    dio.interceptors.addAll(<Interceptor>[logInterceptor()]);

    return dio;
  }

  static Interceptor logInterceptor() {
    return InterceptorsWrapper(
      onError: (DioError e, handler) {
        return handler.next(e);
      },
    );
  }
}
