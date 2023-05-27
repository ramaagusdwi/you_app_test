import 'dart:developer';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_you_app/core/utils/date_picker.dart';
import 'package:flutter_you_app/core/utils/utils.dart';
import 'package:flutter_you_app/core/utils/zodiac_sign.dart';
import 'package:flutter_you_app/domain/entities/about_data.dart';
import 'package:flutter_you_app/presentation/bloc/about_bloc.dart';
import 'package:flutter_you_app/presentation/widgets/about_text_field_decoration.dart';
import 'package:flutter_you_app/presentation/widgets/profile/add_image.dart';
import 'package:flutter_you_app/resource/theme.dart';
import 'package:flutter_you_app/shared_view/base_input_label.dart';
import 'package:intl/intl.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

///class [FormAbout] show form consist  text field display name gender, birthday, horoscope. zodiac, height, and weight not mandatory
///every text field above not mandatory filled, can input or nor
class FormAbout extends StatefulWidget {
  const FormAbout({
    super.key,
  });

  @override
  State<FormAbout> createState() => _FormAboutState();
}

class _FormAboutState extends State<FormAbout> {
  late SingleValueDropDownController _genderController;
  late TextEditingController _displayNameController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;

  String labelBirthdayDefault = 'DD MM YYYY';
  String labelZodiacDefault = '--';
  String labelHoroscopeDefault = '--';

  bool fetchHoroscopeInProgress = false;

  @override
  void initState() {
    _genderController = SingleValueDropDownController();
    _displayNameController = TextEditingController();
    _heightController = TextEditingController();
    _weightController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _genderController.dispose();
    _displayNameController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'About',
              style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: bold),
            ),
            InkWell(
              onTap: () {
                context.read<AboutBloc>().add(AboutSavePressed());
              },
              child: GradientText(
                'Save & Update',
                style: TextStyle(fontSize: 12.0, fontWeight: medium),
                colors: goldensColor,
              ),
            )
          ],
        ),
        // const Spacer(),
        const SizedBox(height: 33),
        const AddImage(),
        const SizedBox(height: 29),
        _displayNameInput(),
        const SizedBox(height: 12),
        _genderInput(),
        const SizedBox(height: 12),
        _birthdayInput(context),
        const SizedBox(height: 12),
        _horoscopeInput(),
        const SizedBox(height: 12),
        _zodiacInput(),
        const SizedBox(height: 12),
        _heightInput(),
        const SizedBox(height: 12),
        _weightInput(),
      ],
    );
  }

  BaseInputLabel _weightInput() {
    int? weight = context.watch<AboutBloc>().state.aboutData.weight;
    String weightLabel = weight == null ? 'Add weight' : weight.toString();
    return BaseInputLabel(
      labelLeftText: 'Weight:',
      labelLeftStyle: whiteOpacity40TextStyle.copyWith(fontSize: 13, fontWeight: bold),
      enabled: true,
      textAlign: TextAlign.left,
      controller: _weightController,
      labelText: weightLabel,
      labelStyle: whiteOpacity40TextStyle,
      hintText: weightLabel,
      hintStyle: whiteOpacity40TextStyle,
      suffixIcon: Text('Kg',
          textAlign: TextAlign.center,
          style: whiteTextStyle.copyWith(
            fontSize: 12,
            height: 2.2,
          )),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your weight';
        }
        return null;
      },
      onChanged: (value) {},
      onSubmitted: (value) {
        AboutData? data = AboutData(weight: int.parse(value!));
        context.read<AboutBloc>().add(AddAboutData(aboutData: data));
      },
      textInputType: TextInputType.number,
      textInputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly], // Onl
    );
  }

  BaseInputLabel _heightInput() {
    int? height = context.watch<AboutBloc>().state.aboutData.height;
    String heightLabel = height == null ? 'Add height' : height.toString();
    String heightHint = 'Add height';
    return BaseInputLabel(
      labelLeftText: 'Height:',
      labelLeftStyle: whiteOpacity40TextStyle.copyWith(fontSize: 13, fontWeight: bold),
      enabled: true,
      textAlign: TextAlign.left,
      controller: _heightController,
      labelText: heightLabel,
      labelStyle: whiteOpacity40TextStyle,
      hintText: heightHint,
      hintStyle: whiteOpacity40TextStyle,
      onChanged: (value) {},
      onSubmitted: (value) {
        AboutData? data = AboutData(height: int.parse(value!));
        context.read<AboutBloc>().add(AddAboutData(aboutData: data));
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your height';
        }
        return null;
      },
      textInputType: TextInputType.number,
      textInputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ], // Only numbers can be entered,
      suffixIcon: Text('Cm',
          textAlign: TextAlign.center,
          style: whiteTextStyle.copyWith(
            fontSize: 12,
            height: 2.2,
          )),
    );
  }

  BaseInputLabel _horoscopeInput() {
    String? horoscope = context.watch<AboutBloc>().state.aboutData.horoscope;
    return BaseInputLabel(
      labelLeftText: 'Horoscope:',
      labelLeftStyle: whiteOpacity40TextStyle.copyWith(fontSize: 13, fontWeight: bold),
      enabled: false,
      textAlign: TextAlign.left,
      labelText: horoscope ?? labelHoroscopeDefault,
      labelStyle: whiteOpacity40TextStyle,
      hintText: horoscope ?? labelHoroscopeDefault,
      hintStyle: whiteOpacity40TextStyle,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select birthday first then auto detect your horoscope';
        }
        return null;
      },
    );
  }

  BaseInputLabel _zodiacInput() {
    String? zodiac = context.watch<AboutBloc>().state.aboutData.zodiac;
    return BaseInputLabel(
      labelLeftText: 'Zodiac:',
      labelLeftStyle: whiteOpacity40TextStyle.copyWith(fontSize: 13, fontWeight: bold),
      enabled: false,
      textAlign: TextAlign.left,
      labelText: zodiac ?? labelZodiacDefault,
      labelStyle: whiteOpacity40TextStyle,
      hintText: zodiac ?? labelZodiacDefault,
      hintStyle: whiteOpacity40TextStyle,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select birthday first then auto detect your zodiac';
        }
        return null;
      },
    );
  }

  Row _genderInput() {
    String? gender = context.watch<AboutBloc>().state.aboutData.gender;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Text(
            'Gender:',
            style: whiteOpacity40TextStyle.copyWith(fontSize: 13, fontWeight: bold),
          ),
        ),
        Flexible(
          flex: 3,
          child: DropDownTextField(
            controller: _genderController,
            clearOption: true,
            textFieldDecoration: aboutTextFieldDecoration(
                labelText: gender ?? 'Select Gender', hintText: gender ?? 'Select Gender'),
            dropDownIconProperty: IconProperty(icon: Icons.keyboard_arrow_down_sharp, color: white),
            clearIconProperty: IconProperty(color: white),
            validator: (value) {
              if (value == null) {
                return "Required field";
              } else {
                return null;
              }
            },
            dropDownItemCount: 2,
            dropdownColor: bgTextField,
            textStyle: whiteTextStyle.copyWith(fontSize: 12),
            listTextStyle: whiteOpacity40TextStyle,
            dropDownList: const [
              DropDownValueModel(name: 'Male', value: "male"),
              DropDownValueModel(name: 'Female', value: "female"),
            ],
            onChanged: (val) {
              log('cekName: ${val.name}');
              log('cekValue: ${val.value}');
              AboutData? data = AboutData(gender: val.name);
              context.read<AboutBloc>().add(AddAboutData(aboutData: data));
            },
          ),
        ),
      ],
    );
  }

  BaseInputLabel _displayNameInput() {
    String? displayName = context.watch<AboutBloc>().state.aboutData.displayName;
    return BaseInputLabel(
        labelLeftText: 'Display name:',
        labelLeftStyle: whiteOpacity40TextStyle.copyWith(fontSize: 13, fontWeight: bold),
        textAlign: TextAlign.left,
        controller: _displayNameController,
        labelText: displayName ?? 'Enter name',
        labelStyle: whiteOpacity40TextStyle,
        hintText: displayName ?? 'Enter name',
        hintStyle: whiteOpacity40TextStyle,
        onSubmitted: (value) {
          AboutData? data = AboutData(displayName: value);
          context.read<AboutBloc>().add(AddAboutData(aboutData: data));
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your display name';
          }
          return null;
        });
  }

  BaseInputLabel _birthdayInput(BuildContext context) {
    DateTime? birthday = context.watch<AboutBloc>().state.aboutData.birthday;

    return BaseInputLabel(
      enabled: false,
      labelLeftText: 'Birthday:',
      labelLeftStyle: whiteOpacity40TextStyle.copyWith(
        fontSize: 13,
        fontWeight: bold,
      ),
      textAlign: TextAlign.left,
      labelText: birthday == null
          ? labelBirthdayDefault
          : Utils.dateToString(birthday, Utils.DISPLAY_DATE_FORMAT3),
      labelStyle: whiteTextStyle,
      hintText: labelBirthdayDefault,
      hintStyle: whiteOpacity40TextStyle,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your birthday';
        }
        return null;
      },
      onTap: () async {
        DatePickerHelper.show(context, (dateTime) {
          final int year = dateTime.year;

          var formattedDate = DateFormat('dd MM yyyy').format(dateTime);

          labelBirthdayDefault = formattedDate;
          labelZodiacDefault = getZodiacSign(dateTime);
          labelHoroscopeDefault = calculateChineseZodiac(year);
          fetchHoroscopeInProgress = false;

          AboutData? data = AboutData(
              birthday: dateTime, zodiac: labelZodiacDefault, horoscope: labelHoroscopeDefault);

          context.read<AboutBloc>().add(AddAboutData(aboutData: data));
        });
      },
    );
  }
}
