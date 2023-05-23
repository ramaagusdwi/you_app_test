import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_you_app/core/theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String labelText;
  final TextStyle labelStyle;
  final String hintText;
  final TextStyle hintStyle;
  final String? errorText;
  final TextStyle? errorStyle;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obsureText;
  final String? Function(String?)? validator;
  final Color? filledColor;
  final bool useBorderSide;
  final bool enabled;
  final int maxLines;
  final bool collapsedInputDecoration;
  final TextAlign textAlign;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputTypeFormatters;
  final Function(String?)? onSubmitted;
  final Function(String?)? onChanged;

  CustomTextField({
    required this.textEditingController,
    required this.labelText,
    required this.labelStyle,
    required this.hintText,
    required this.hintStyle,
    required this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.obsureText = false,
    this.filledColor,
    this.useBorderSide = false,
    this.enabled = true,
    this.maxLines = 1,
    this.collapsedInputDecoration = false,
    this.textAlign = TextAlign.left,
    this.textInputType,
    this.inputTypeFormatters,
    this.onSubmitted,
    this.onChanged,
    this.errorText,
    this.errorStyle,
  });

  @override
  Widget build(BuildContext context) {
    const defaultContentPadding = EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 16,
    );

    final double iconSquareSize = 24.w;

    final double leftContentPadding = defaultContentPadding.left;
    final double rightContentPadding = defaultContentPadding.right;

    // gap between prefix/suffix icon & input field
    final double iconToInputFieldGap = 10.w;

    return TextFormField(
      obscureText: obsureText,
      inputFormatters: inputTypeFormatters,
      keyboardType: textInputType,
      style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: medium),
      enabled: enabled,
      textAlign: textAlign,
      controller: textEditingController,
      maxLines: maxLines,
      decoration: collapsedInputDecoration
          ? InputDecoration.collapsed(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              fillColor: filledColor ?? Color(0xFF253D42),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9.0),
                borderSide: useBorderSide
                    ? const BorderSide(width: 1.5, color: whiteOpacity6)
                    : BorderSide.none,
              ),
              hintText: hintText,
              hintStyle: hintStyle,
            )
          : InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              fillColor: filledColor ?? Color(0xFF253D42),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9.0),
                borderSide: useBorderSide
                    ? const BorderSide(width: 1.5, color: whiteOpacity6)
                    : BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9.0),
                borderSide: useBorderSide
                    ? const BorderSide(width: 1.5, color: whiteOpacity6)
                    : BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9.0),
                borderSide: useBorderSide
                    ? const BorderSide(width: 1.5, color: whiteOpacity6)
                    : BorderSide.none,
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9.0),
                borderSide: useBorderSide
                    ? const BorderSide(width: 1.5, color: whiteOpacity6)
                    : BorderSide.none,
              ),
              labelText: labelText,
              labelStyle: labelStyle,
              hintText: hintText,
              hintStyle: hintStyle,
              errorText: errorText,
              errorStyle: errorStyle,
              suffixIcon: suffixIcon,
              // suffixIconConstraints: BoxConstraints.tight(
              //   const Size(30, 20),
              // ),
              suffixIconConstraints: BoxConstraints.tight(
                Size(
                  [
                    rightContentPadding + 29.w,
                    if (suffixIcon != null) ...[
                      if (suffixIcon != null) iconSquareSize,
                      iconToInputFieldGap,
                    ]
                  ].reduce((value, element) => value + element),
                  iconSquareSize + 12.w,
                ),
              ),
              prefixIcon: prefixIcon,
            ),
      validator: validator,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
    );
  }
}
