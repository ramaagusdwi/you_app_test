part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmationPassword = const ConfirmationPassword.pure(),
    this.name = const Name.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  final Email email;
  final Password password;
  final ConfirmationPassword confirmationPassword;
  final Name name;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  @override
  List<Object?> get props =>
      [email, name, password, confirmationPassword, status, isValid, errorMessage];

  RegisterState copyWith({
    Email? email,
    Password? password,
    ConfirmationPassword? confirmationPassword,
    Name? name,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmationPassword: confirmationPassword ?? this.confirmationPassword,
      name: name ?? this.name,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
