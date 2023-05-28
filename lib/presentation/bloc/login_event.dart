part of 'login_bloc.dart';

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
  LoginEntity loginEntity;
  LoginPressed(this.loginEntity);
}
