import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_you_app/data/models/register_error.dart';
import 'package:flutter_you_app/domain/repositories/auth_repository.dart';

class Register {
  final AuthRepository _repository;

  const Register(this._repository);

  Future<Either<RegisterError, bool>> execute(RegisterParams body) async {
    return await _repository.register(body);
  }
}

class RegisterParams extends Equatable {
  final String name;
  final String email;
  final String password;

  const RegisterParams({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  @override
  List<Object> get props => [name, email, password];
}
