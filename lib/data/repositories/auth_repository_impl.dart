import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_you_app/core/errors/app_error.dart';
import 'package:flutter_you_app/core/errors/error_handler.dart';
import 'package:flutter_you_app/core/errors/socket_error.dart';
import 'package:flutter_you_app/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_you_app/data/models/register_error.dart';
import 'package:flutter_you_app/domain/entities/login_entity.dart';
import 'package:flutter_you_app/domain/repositories/auth_repository.dart';
import 'package:flutter_you_app/domain/usecase/register.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final Dio _dio;
  final ErrorHandler errorHandler;

  AuthRepositoryImpl(
    this._remoteDataSource,
    this._dio,
    this.errorHandler,
  );

  //cached access token and refresh token
  String? _accessToken;

  @override
  Future<Either<AppError, String>> login(
    LoginEntity loginEntity,
  ) async {
    try {
      String loginResponseModel = await _remoteDataSource.login(loginEntity.json);
      if (loginResponseModel.contains('User not found')) {
        return const Left(AppError('User not found!'));
      }
      return Right(loginResponseModel);
    } on SocketException catch (_) {
      return const Left(SocketError());
    } on Exception catch (e, trace) {
      if (e is DioError && e.response?.data is Map) {
        // String errorResponse = jsonEncode(e.response?.data);
        Map<String, String> error = e.response?.data;
        String message = error['message']!;
        return Left(AppError(message));
      }
      String message = errorHandler.handle(e, trace, message: 'Login gagal');
      return Left(AppError(message));
    } catch (e, stackTrace) {
      return Left(AppError('Error ' + e.toString()));
    }
  }

  @override
  Future<Either<RegisterError, bool>> register(RegisterParams body) async {
    try {
      final result = await _remoteDataSource.register(body.toJson());
      return Right(result);
    } on RegisterError catch (e, stackTrace) {
      return Left(e);
    } on Exception catch (e, trace) {
      String message = errorHandler.handle(e, trace, message: 'Register gagal');
      return Left(RegisterError(message: message));
    }
  }
}
