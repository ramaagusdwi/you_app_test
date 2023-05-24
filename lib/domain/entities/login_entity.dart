import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  String email;
  String password;
 
  LoginEntity({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> get json => {
        'email': email,
        'password': password,
      };

  factory LoginEntity.fromMap(Map<String, dynamic> data) => LoginEntity(
        email: data['email'],
        password: data['password'],
      );

  @override
  List<Object?> get props => [email, password];
}
