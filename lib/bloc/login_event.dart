import 'package:flutter_you_app/models/email.dart';
import 'package:flutter_you_app/models/password.dart';

sealed class LoginEvent {}

final class LoginEmailChanged extends LoginEvent {
  String email;
  LoginEmailChanged(this.email);
}

final class LoginPasswordChanged extends LoginEvent {
  String password;
  LoginPasswordChanged(this.password);
}
