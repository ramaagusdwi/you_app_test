import 'package:flutter/material.dart';
import 'package:flutter_you_app/core/theme.dart';

class ItemLabelAbout extends StatelessWidget {
  final String labelLeftText;
  final String labelRightText;

  const ItemLabelAbout({super.key, required this.labelLeftText, required this.labelRightText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          labelLeftText,
          style: whiteOpacity40TextStyle.copyWith(fontSize: 13, fontWeight: medium),
        ),
        const SizedBox(width: 4),
        Text(
          labelRightText,
          style: whiteTextStyle.copyWith(fontSize: 13, fontWeight: medium),
        ),
      ],
    );
    ;
  }
}
