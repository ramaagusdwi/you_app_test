part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmationPassword = const ConfirmationPassword.pure(),
    this.username = const Username.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  final Email email;
  final Password password;
  final ConfirmationPassword confirmationPassword;
  final Username username;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  @override
  List<Object?> get props =>
      [email, username, password, confirmationPassword, status, isValid, errorMessage];

  RegisterState copyWith({
    Email? email,
    Password? password,
    ConfirmationPassword? confirmationPassword,
    Username? name,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmationPassword: confirmationPassword ?? this.confirmationPassword,
      username: name ?? this.username,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
