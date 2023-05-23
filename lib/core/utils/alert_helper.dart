import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_you_app/core/theme.dart';

class AlertHelper {
  const AlertHelper._();

  static GlobalKey<ScaffoldMessengerState> snackbarKey = GlobalKey<ScaffoldMessengerState>();
  static BuildContext context = snackbarKey.currentContext!;

  static void showSnackBar(
    String message, {
    Color? color,
    Color? textColor,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    bool isError = false,
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 1),
    String? actionLabel,
    VoidCallback? actionOnPressed,
  }) {
    snackbarKey.currentState?.clearSnackBars();
    backgroundColor = backgroundColor2;
    snackbarKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor: isError ? Colors.red : backgroundColor,
        behavior: behavior,
        duration: duration,
        content: Text(
          message,
          style: whiteTextStyle,
        ),
        action: (actionLabel != null && actionOnPressed != null)
            ? SnackBarAction(
                textColor: blueDowny,
                label: actionLabel,
                onPressed: actionOnPressed,
              )
            : null,
      ),
    );
  }
}
