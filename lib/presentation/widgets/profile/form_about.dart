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
import 'package:flutter_you_app/shared_view/custom_text_field_with_left_label.dart';
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
                String? displayName = _displayNameController.text;
                String? gender = _genderController.dropDownValue?.name ?? '';
                DateTime? birthday = context.read<AboutBloc>().state.aboutData.birthday;
                String? horoscopeValue = context.read<AboutBloc>().state.aboutData.horoscope;
                String? zodiac = context.read<AboutBloc>().state.aboutData.zodiac;
                int? height = int.parse(_heightController.text);
                int? weight = int.parse(_weightController.text);
                String? imagePath = context.read<AboutBloc>().state.aboutData.pathImage;
                var data = AboutData(
                    displayName: displayName,
                    birthday: birthday,
                    gender: gender,
                    horoscope: horoscopeValue,
                    height: height,
                    weight: weight,
                    zodiac: zodiac,
                    pathImage: imagePath);
                context.read<AboutBloc>().add(AboutAddData(aboutData: data));
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

  CustomTextFieldWithLeftLabel _weightInput() {
    int? weightValue = context.watch<AboutBloc>().state.aboutData.weight;
    String weightLabel = weightValue == null ? 'Add weight' : weightValue.toString();
    return CustomTextFieldWithLeftLabel(
      labelLeftText: 'Weight:',
      labelLeftStyle: whiteOpacity40TextStyle.copyWith(fontSize: 13, fontWeight: bold),
      enabled: true,
      textAlign: TextAlign.left,
      controller: _weightController,
      labelText: weightLabel,
      labelStyle: weightValue == null ? whiteOpacity40TextStyle : whiteTextStyle,
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
        context.read<AboutBloc>().add(AboutAddData(aboutData: data));
      },
      textInputType: TextInputType.number,
      textInputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly], // Onl
    );
  }

  CustomTextFieldWithLeftLabel _heightInput() {
    int? heightValue = context.watch<AboutBloc>().state.aboutData.height;
    String heightLabel = heightValue == null ? 'Add height' : heightValue.toString();
    String heightHint = 'Add height';
    return CustomTextFieldWithLeftLabel(
      labelLeftText: 'Height:',
      labelLeftStyle: whiteOpacity40TextStyle.copyWith(fontSize: 13, fontWeight: bold),
      enabled: true,
      textAlign: TextAlign.left,
      controller: _heightController,
      labelText: heightLabel,
      labelStyle: heightValue == null ? whiteOpacity40TextStyle : whiteTextStyle,
      hintText: heightHint,
      hintStyle: heightValue == null ? whiteOpacity40TextStyle : whiteTextStyle,
      onChanged: (value) {},
      onSubmitted: (value) {
        AboutData? data = AboutData(height: int.parse(value!));
        context.read<AboutBloc>().add(AboutAddData(aboutData: data));
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

  CustomTextFieldWithLeftLabel _horoscopeInput() {
    String? horoscopeValue = context.watch<AboutBloc>().state.aboutData.horoscope;
    return CustomTextFieldWithLeftLabel(
      labelLeftText: 'Horoscope:',
      labelLeftStyle: whiteOpacity40TextStyle.copyWith(fontSize: 13, fontWeight: bold),
      enabled: false,
      textAlign: TextAlign.left,
      labelText: horoscopeValue ?? labelHoroscopeDefault,
      labelStyle: horoscopeValue == null ? whiteOpacity40TextStyle : whiteTextStyle,
      hintText: horoscopeValue ?? labelHoroscopeDefault,
      hintStyle: horoscopeValue == null ? whiteOpacity40TextStyle : whiteTextStyle,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select birthday first then auto detect your horoscope';
        }
        return null;
      },
    );
  }

  CustomTextFieldWithLeftLabel _zodiacInput() {
    String? zodiacValue = context.watch<AboutBloc>().state.aboutData.zodiac;
    return CustomTextFieldWithLeftLabel(
      labelLeftText: 'Zodiac:',
      labelLeftStyle: whiteOpacity40TextStyle.copyWith(fontSize: 13, fontWeight: bold),
      enabled: false,
      textAlign: TextAlign.left,
      labelText: zodiacValue ?? labelZodiacDefault,
      labelStyle: zodiacValue == null ? whiteOpacity40TextStyle : whiteTextStyle,
      hintText: zodiacValue ?? labelZodiacDefault,
      hintStyle: zodiacValue == null ? whiteOpacity40TextStyle : whiteTextStyle,
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
              context.read<AboutBloc>().add(AboutAddData(aboutData: data));
            },
          ),
        ),
      ],
    );
  }

  CustomTextFieldWithLeftLabel _displayNameInput() {
    String? displayName = context.watch<AboutBloc>().state.aboutData.displayName;
    return CustomTextFieldWithLeftLabel(
        labelLeftText: 'Display name:',
        labelLeftStyle: whiteOpacity40TextStyle.copyWith(fontSize: 13, fontWeight: bold),
        textAlign: TextAlign.left,
        controller: _displayNameController,
        labelText: displayName ?? 'Enter name',
        labelStyle: displayName == null ? whiteOpacity40TextStyle : whiteTextStyle,
        hintText: displayName ?? 'Enter name',
        hintStyle: displayName == null ? whiteOpacity40TextStyle : whiteTextStyle,
        onSubmitted: (value) {
          AboutData? data = AboutData(displayName: value);
          context.read<AboutBloc>().add(AboutAddData(aboutData: data));
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your display name';
          }
          return null;
        });
  }

  CustomTextFieldWithLeftLabel _birthdayInput(BuildContext context) {
    DateTime? birthday = context.watch<AboutBloc>().state.aboutData.birthday;

    return CustomTextFieldWithLeftLabel(
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

          context.read<AboutBloc>().add(AboutAddData(aboutData: data));
        });
      },
    );
  }
}
