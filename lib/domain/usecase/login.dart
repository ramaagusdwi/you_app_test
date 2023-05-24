import 'package:dartz/dartz.dart';
import 'package:flutter_you_app/core/errors/app_error.dart';
import 'package:flutter_you_app/domain/entities/login_entity.dart';
import 'package:flutter_you_app/domain/repositories/auth_repository.dart';

class Login {
  final AuthRepository _repository;
  Login(this._repository);
  Future<Either<AppError, String>> execute(LoginEntity entity) async {
    return _repository.login(
      entity,
    );
  }
}
