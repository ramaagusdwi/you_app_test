import 'package:flutter/material.dart';
import 'package:flutter_you_app/resource/theme.dart';

class SmallCircularLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.only(top: 30),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          backgroundColor: blueDowny,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 16,
              height: 16,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(
                  white,
                ),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              'Loading',
              style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: medium, color: white),
            ),
          ],
        ),
      ),
    );
  }
}
