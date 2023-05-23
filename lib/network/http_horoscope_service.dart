import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_you_app/core/constant/url_constant.dart';
import 'package:flutter_you_app/network/base_http.dart';

class HTTPHoroscopeService {
  final tag = 'HoroscopeService';
  static HTTPHoroscopeService? _instance;

  factory HTTPHoroscopeService() => _instance ??= HTTPHoroscopeService._();

  HTTPHoroscopeService._();

  Future<Either<String, String>> dailyPredictionPost({
    required String signZodiac,
  }) async {
    try {
      const baseUrl = UrlConstants.BASE_URL_ASTRO;
      const endpoint = UrlConstants.DAILY_PREDICITION;
      final dio = Dio();

      Response<dynamic> response = await dio.post(
        baseUrl + endpoint + signZodiac,
        options: Options(
          headers: await BaseHTTP.getAuthHeaders(),
        ),
      );

      log(response.data.toString(), name: '$tag-response');
      log(response.statusCode.toString(), name: '$tag-code');

      if (response.statusCode == 200) {
        Map<String, dynamic> result = response.data;
        String healthHoroscope = result['prediction']['health'];
        return Right(healthHoroscope.trim());
      } else {
        return const Left('Terjadi kesalahan yang tidak diketahui.');
      }
    } on Exception catch (e, t) {
      return const Left('Terjadi kesalahan yang tidak diketahui.');
    }
  }
}
