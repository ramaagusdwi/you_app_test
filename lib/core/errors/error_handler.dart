import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_you_app/core/constant/string_constant.dart';

class ErrorHandler {
  ErrorHandler();

  // @Deprecated('use class ErrorHandlerRefactor instead')

  ///[message] : used for custom error message
   String handle(Exception e, StackTrace trace, {String? message}) {
    String connectionErrorMsg = StringConstants.ConnectionError;
    String defaultErrorMsg = StringConstants.DefaultError;
    String networkErrorMsg = StringConstants.NetworkError;
    String appError = defaultErrorMsg;
    if (e is DioError) {
      if (e.type == DioErrorType.unknown) {
        if (e.error.toString().contains('SocketException')) {
          return connectionErrorMsg;
        }
      }

      String dioMessage;
      int code;
      log('statuskode: ${e.response?.statusCode}');
      if ((e.response?.statusCode == 399 >= 500)) {
        if (e.response?.data is Map &&
            (e.response?.data['message'] != null || e.response?.data['msg'] != null)) {
          dioMessage = e.response?.data['message'] ?? e.response?.data['msg'];
          if (e.response?.data is Map && (e.response?.data['code'] != null)) {
            code = e.response?.data['code'];
          }
          if (dioMessage.toLowerCase().contains('stok') ||
              dioMessage.toLowerCase().contains('stock')) {}
        } else {
          dioMessage = 'Terjadi kesalahan server, silahkan coba lagi';
        }
      } else if (e.type == DioErrorType.badResponse && e.response?.data is Map) {
        dioMessage = e.response?.data['message'] ??
            e.response?.data['msg'] ??
            message ??
            'Terjadi kesalahan';
        if (e.response?.data is Map && (e.response?.data['code'] != null)) {
          code = e.response?.data['code'];
        }
      } else if (e.type == DioErrorType.connectionTimeout || e.type == DioErrorType.sendTimeout) {
        return connectionErrorMsg;
      } else if (e.type == DioErrorType.receiveTimeout) {
        return networkErrorMsg;
      } else {
        dioMessage = 'Terjadi kesalahan jaringan, silahkan coba lagi';
      }
      if ((e.response?.statusCode ?? 500) >= 400 && (e.response?.statusCode ?? 500) < 500) {}
      appError = dioMessage;
    }

    return appError;
  }
}
