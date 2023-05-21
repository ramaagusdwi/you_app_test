import 'package:flutter/material.dart';
import 'package:flutter_you_app/theme.dart';

class BackButtonChevron extends StatelessWidget {
  const BackButtonChevron({
    Key? key,
    this.backButtonColor,
    this.onBackPressed,
  }) : super(key: key);

  final Color? backButtonColor;
  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onBackPressed ?? () => Navigator.pop(context),
      child: Icon(
        Icons.chevron_left,
        size: 40,
        color: backButtonColor ?? blackColor,
      ),
    );
  }
}
