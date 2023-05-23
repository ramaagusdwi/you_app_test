import 'package:flutter_you_app/core/errors/app_error.dart';

class SocketError extends AppError {
  const SocketError({
    String message = 'Gagal menghubungkan ke server, silahkan coba lagi',
  }) : super(message);
}
