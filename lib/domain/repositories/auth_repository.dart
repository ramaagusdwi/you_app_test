import 'package:dartz/dartz.dart';
import 'package:flutter_you_app/core/errors/app_error.dart';
import 'package:flutter_you_app/data/models/register_error.dart';
import 'package:flutter_you_app/domain/entities/login_entity.dart';
import 'package:flutter_you_app/domain/usecase/register.dart';

abstract class AuthRepository {
  Future<Either<AppError, bool>> login(LoginEntity loginEntity);
  Future<Either<RegisterError, bool>> register(RegisterParams body);
}
