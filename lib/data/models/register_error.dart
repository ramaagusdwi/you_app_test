import 'package:flutter_you_app/core/errors/app_error.dart';

class RegisterError extends AppError {
  final bool isPhoneFieldError;

  const RegisterError({this.isPhoneFieldError = false, String message = ''})
      : super(message);
}
