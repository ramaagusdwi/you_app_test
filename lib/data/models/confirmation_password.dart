import 'package:formz/formz.dart';

/// Validation errors for the [Password] [FormzInput].
enum ConfirmationPasswordValidationError {
  /// Generic invalid error.
  invalid,
  notMatch,
}

/// {@template password}
/// Form input for an password input.
/// {@endtemplate}
class ConfirmationPassword extends FormzInput<List<String>, ConfirmationPasswordValidationError> {
  /// {@macro password}
  const ConfirmationPassword.pure() : super.pure(const ['', '']);

  /// {@macro password}
  const ConfirmationPassword.dirty([super.value = const ['', '']]) : super.dirty();

  static final _passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  ConfirmationPasswordValidationError? validator(List<String?> value) {
    if (value[0] != value[1]) {
      return ConfirmationPasswordValidationError.notMatch;
    }
    return _passwordRegExp.hasMatch(value[0] ?? '')
        ? null
        : ConfirmationPasswordValidationError.invalid;
  }
}
