import 'package:flutter/material.dart';
import 'package:flutter_you_app/resource/theme.dart';

class PrimaryButton extends StatelessWidget {
  Function()? onPressed;
  String title;
  double? width;
  double? height;
  double? radius;
  
  PrimaryButton({
    Key? key,
    this.onPressed,
    required this.title,
    this.width,
    this.height,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  blueDowny,
                  celestialBlue,
                ],
              ),
              borderRadius: BorderRadius.circular(9.0),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(-10, 20),
                  color: blueDowny50,
                  blurRadius: 15,
                  spreadRadius: -10,
                ),
                BoxShadow(
                  offset: Offset(15, 20),
                  color: celestialBlue50,
                  blurRadius: 15,
                  spreadRadius: -10,
                ),
              ]
          ),
          height: height ?? 48,
          width: width ?? double.infinity,
          child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(foregroundColor: Colors.transparent),
            // style: TextButton.styleFrom(
            //   backgroundColor: primaryColor,
            //   disabledBackgroundColor: disableColor,
            //   disabledForegroundColor: secondaryTextColor,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(radius ?? 14),
            //   ),
            // ),
            child: Text(
              title,
              style: whiteTextStyle.copyWith(
                fontWeight: bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
    
  }
}
