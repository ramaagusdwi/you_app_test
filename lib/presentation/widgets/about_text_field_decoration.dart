import 'package:flutter/material.dart';
import 'package:flutter_you_app/resource/theme.dart';

InputDecoration aboutTextFieldDecoration({required String labelText, required String hintText}) =>
    InputDecoration(
  floatingLabelBehavior: FloatingLabelBehavior.never,
  filled: true,
  fillColor: bgTextField,
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(9.0),
      borderSide: const BorderSide(width: 1, color: whiteOpacity6)),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(9.0),
    borderSide: const BorderSide(width: 1, color: whiteOpacity6),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(9.0),
    borderSide: const BorderSide(width: 1, color: whiteOpacity6),
  ),
      labelText: labelText,
  labelStyle: whiteOpacity40TextStyle.copyWith(fontSize: 12),
      hintText: hintText,
  hintStyle: whiteOpacity40TextStyle.copyWith(fontSize: 12),
);
