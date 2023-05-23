import 'package:flutter/material.dart';
import 'package:flutter_you_app/core/theme.dart';

var aboutTextFieldDecoration = InputDecoration(
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
  labelText: 'Select Gender',
  labelStyle: whiteOpacity40TextStyle.copyWith(fontSize: 12),
  hintText: 'Select Gender',
  hintStyle: whiteOpacity40TextStyle.copyWith(fontSize: 12),
);
