

import 'package:flutter_you_app/domain/entities/login_entity.dart';

class LoginEvent {}

class LoginEmailChanged extends LoginEvent {
  String email;
  LoginEmailChanged(this.email);
}

class LoginPasswordChanged extends LoginEvent {
  String password;
  LoginPasswordChanged(this.password);
}


class LoginPressed extends LoginEvent {
  LoginPressed();
}
