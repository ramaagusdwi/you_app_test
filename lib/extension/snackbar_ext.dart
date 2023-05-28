import 'package:flutter/material.dart';
import 'package:flutter_you_app/resource/theme.dart';

extension SnackBarExt on BuildContext {
  void buildErrorSnackBar(String message) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: backgroundColor,
          duration: const Duration(seconds: 4),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          content: Text(message, style: whiteTextStyle, overflow: TextOverflow.ellipsis)));
  }
}
