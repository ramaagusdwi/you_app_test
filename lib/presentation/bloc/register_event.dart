part of 'register_bloc.dart';

class RegisterEvent {}

class RegisterEmailChanged extends RegisterEvent {
  String email;
  RegisterEmailChanged(this.email);
}

class RegisterPasswordChanged extends RegisterEvent {
  String password;
  RegisterPasswordChanged(this.password);
}

class RegisterConfirmationPasswordChanged extends RegisterEvent {
  String confirmationPassword;
  RegisterConfirmationPasswordChanged(this.confirmationPassword);
}

class RegisterUsernameChanged extends RegisterEvent {
  String username;
  RegisterUsernameChanged(this.username);
}

class RegisterPressed extends RegisterEvent {
  RegisterPressed();
}
