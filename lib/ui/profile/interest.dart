import 'package:flutter/material.dart';
import 'package:flutter_you_app/theme.dart';

class Interest extends StatefulWidget {
  const Interest({super.key});

  @override
  State<Interest> createState() => _InterestState();
}

class _InterestState extends State<Interest> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 109,
      padding: const EdgeInsets.fromLTRB(27, 17, 27, 23),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: blackPearlColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Interest',
                style: whiteTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: bold,
                ),
              ),
              Container(
                height: 17,
                width: 17,
                child: Image.asset('assets/edit.png'),
              ),
            ],
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              'Add in your interest to find a better match',
              style: whiteOpacity52TextStyle.copyWith(
                fontSize: 14,
                fontWeight: bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
