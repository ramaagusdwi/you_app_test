import 'package:dio/dio.dart';
import 'package:flutter_you_app/constant/url_constant.dart';

class Api {
  final dio = createDio();
  final tokenDio = Dio(BaseOptions(baseUrl: UrlConstants.BASE_URL));

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      headers: {'Content-Type': 'application/json'},
      baseUrl: UrlConstants.BASE_URL,
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
