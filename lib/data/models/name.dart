import 'package:formz/formz.dart';

enum UsernameValidationError { empty, invalid }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  @override
  UsernameValidationError? validator(String value) {
    if (value.isEmpty) {
      return UsernameValidationError.empty;
    } else if (value.length < 3) {
      return UsernameValidationError.invalid;
    } else {
      return null;
    }
  }

  static String? showNameErrorMessage(UsernameValidationError? error) {
    if (error == UsernameValidationError.empty) {
      return 'Empty name';
    } else if (error == UsernameValidationError.invalid) {
      return 'Too short name';
    } else {
      return null;
    }
  }
}
