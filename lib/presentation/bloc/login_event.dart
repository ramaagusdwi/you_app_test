

class LoginEvent {}

class LoginEmailChanged extends LoginEvent {
  String email;
  LoginEmailChanged(this.email);
}

class LoginPasswordChanged extends LoginEvent {
  String password;
  LoginPasswordChanged(this.password);
}
