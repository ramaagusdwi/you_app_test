import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_you_app/shared_view/custom_text_field.dart';



class BaseInputLabel extends StatelessWidget {
  final String labelText;
  final TextStyle labelStyle;
  final String hintText;
  final TextStyle hintStyle;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextAlign textAlign;
  final VoidCallback? onTap;
  final String labelLeftText;
  final TextStyle labelLeftStyle;
  final bool enabled;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? textInputFormatters;
  final Widget? suffixIcon;
  final String? Function(String?)? onSubmitted;
  final String? Function(String?)? onChanged;

  const BaseInputLabel({
    super.key,
    required this.labelText,
    required this.labelStyle,
    required this.hintText,
    required this.hintStyle,
    this.controller,
    required this.validator,
    required this.textAlign,
    this.onTap,
    required this.labelLeftText,
    required this.labelLeftStyle,
    this.enabled = true,
    this.textInputType,
    this.textInputFormatters,
    this.suffixIcon,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Text(
            labelLeftText,
            style: labelLeftStyle,
            // style: whiteOpacity40TextStyle.copyWith(
            //   fontSize: 13,
            //   fontWeight: bold,
            // ),
          ),
        ),
        Flexible(
          flex: 3,
          child: GestureDetector(
            onTap: onTap,
            child: CustomTextField(
              enabled: enabled,
              textAlign: textAlign,
              useBorderSide: true,
              textEditingController: controller,
              labelText: labelText,
              labelStyle: labelStyle,
              hintText: hintText,
              hintStyle: hintStyle,
              validator: validator,
              textInputType: textInputType,
              inputTypeFormatters: textInputFormatters,
              suffixIcon: suffixIcon,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
            ),
          ),
        ),
      ],
    );
  }
}
