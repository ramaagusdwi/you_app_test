import 'package:flutter_you_app/core/errors/app_error.dart';

class RegisterError extends AppError {

  const RegisterError({String message = ''})
      : super(message);
}
