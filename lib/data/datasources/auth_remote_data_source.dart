import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_you_app/core/constant/api_path_constant.dart';
import 'package:flutter_you_app/data/models/register_error.dart';

abstract class AuthRemoteDataSource {
  Future<String> login(Map<String, dynamic> body);
  Future<bool> register(Map<String, dynamic> body);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<String> login(Map<String, dynamic> body) async {
    final res = await _dio.get(ApiPathConstants.login, queryParameters: body);
    Map data = res.data;
    return data['message'];
  }

  @override
  Future<bool> register(Map<String, dynamic> body) async {
    try {
      final response = await _dio.post(ApiPathConstants.register, data: body);
      return response.statusCode == 201;
    } on DioError catch (e) {
      final data = e.response?.data;

      if (data == null || data is! Map) throw const RegisterError();

      final defaultErrorMessage = data['message'] ?? 'Terjadi Kesalahan';

      throw RegisterError(message: defaultErrorMessage);
    }
  }
}
