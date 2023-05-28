// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_you_app/core/constant/image_constant.dart';
import 'package:flutter_you_app/presentation/bloc/about_bloc.dart';
import 'package:flutter_you_app/resource/theme.dart';

class CoverProfile extends StatelessWidget {
  final String username;

  const CoverProfile({
    Key? key,
    required this.username,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutBloc, AboutState>(
      builder: (context, state) {
        return Container(
          height: 190,
          width: double.infinity,
          decoration: BoxDecoration(
            color: grey,
            image: state.aboutData.pathImage == null
                ? null
                : DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(
                      File(state.aboutData.pathImage!),
                    ),
                  ),
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                //displayName or username , age
                //to do, show age obtain from input text field birthday
             
                Text(
                  state.aboutData.displayName ?? '',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                const SizedBox(height: 6),

                if (state.status == AboutStatus.doneEdit) ...[
                  Text(
                    state.aboutData.displayName!,
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    state.aboutData.gender ?? '',
                    style: whiteTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _chipList(state),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

Map<String, String> zodiac = {
  'aries': ImageConstant.aries,
  'taurus': ImageConstant.taurus,
  'gemini': ImageConstant.gemini,
  'cancer': ImageConstant.cancer,
  'leo': ImageConstant.leo,
  'virgo': ImageConstant.virgo,
  'libra': ImageConstant.libra,
  'scorpio': ImageConstant.scorpio,
  'sagitarius': ImageConstant.sagitarius,
  'capricorn': ImageConstant.capricorn,
  'aquarius': ImageConstant.aquarius,
  'pisces': ImageConstant.pisces,
  'rat': ImageConstant.rat,
  'ox': ImageConstant.ox,
  'tiger': ImageConstant.tiger,
  'rabbit': ImageConstant.rabbit,
  'dragon': ImageConstant.dragon,
  'snake': ImageConstant.snake,
  'horse': ImageConstant.horse,
  'goat': ImageConstant.goat,
  'monkey': ImageConstant.monkey,
  'rooster': ImageConstant.rooster,
  'dog': ImageConstant.dog,
  'pig': ImageConstant.pig,
  'sheep': ImageConstant.ox,
};

Widget _buildChip(String label, Color color) {
  String labelLowerCase = label.toLowerCase();
  String assetZodiac = zodiac[labelLowerCase]!;
  return Chip(
    labelPadding: const EdgeInsets.all(2.0),
    avatar: Image.asset(assetZodiac),
    label: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    backgroundColor: color,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
  );
}

_chipList(AboutState state) {
  return Wrap(
    spacing: 15.0,
    runSpacing: 6.0,
    children: <Widget>[
      state.aboutData.zodiac == null
          ? const SizedBox.shrink()
          : _buildChip(state.aboutData.zodiac!, Color(0xFF222421)),
      state.aboutData.horoscope == null
          ? const SizedBox.shrink()
          : _buildChip(state.aboutData.horoscope!, Color(0xFF222421)),
      // _buildChip('rooster', const Color(0xFF222421)),
    ],
  );
}
