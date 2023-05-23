

sealed class LoginEvent {}

final class LoginEmailChanged extends LoginEvent {
  String email;
  LoginEmailChanged(this.email);
}

final class LoginPasswordChanged extends LoginEvent {
  String password;
  LoginPasswordChanged(this.password);
}
