import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_you_app/network/http_horoscope_service.dart';
import 'package:flutter_you_app/theme.dart';
import 'package:flutter_you_app/ui/profile/add_image.dart';
import 'package:flutter_you_app/ui/widgets/about_text_field_decoration.dart';
import 'package:flutter_you_app/ui/widgets/base_input_label.dart';
import 'package:flutter_you_app/ui/widgets/custom_text_field.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter_you_app/ui/widgets/item_label_about.dart';
import 'package:flutter_you_app/utils/date_picker.dart';
import 'package:flutter_you_app/utils/take_photo_bottomsheet.dart';
import 'package:flutter_you_app/utils/utils.dart';
import 'package:flutter_you_app/utils/zodiac_sign.dart';
import 'package:intl/intl.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class About extends StatefulWidget {
  final ValueChanged<bool>? updateDataCallback;
  const About({super.key, this.updateDataCallback});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  bool isEditState = false;
  bool isUpdateData = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 17, 16, 23),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: blackPearlColor,
      ),
      child: !isEditState && !isUpdateData
          ? AboutContent(onTap: () {
              setState(() {
                isEditState = true;
              });
            })
          : isUpdateData
              ? AboutContentWithData(onTap: () {})
              : EditAboutContent(onTap: () {
                  setState(() {
                    isEditState = false;
                    isUpdateData = true;
                  });
                  widget.updateDataCallback!(true);
                }),
    );
  }
}

class AboutContent extends StatelessWidget {
  final VoidCallback onTap;
  const AboutContent({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'About',
              style: whiteTextStyle.copyWith(
                fontSize: 14,
                fontWeight: bold,
              ),
            ),
            InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 17,
                  width: 17,
                  child: Image.asset('assets/edit.png'),
                ),
              ),
            ),
          ],
        ),
        // const Spacer(),
        const SizedBox(height: 33),
        Text(
          'Add in your your to help others know you better',
          style: whiteOpacity52TextStyle.copyWith(
            fontSize: 14,
            fontWeight: bold,
          ),
        ),
      ],
    );
  }
}

class AboutContentWithData extends StatelessWidget {
  final VoidCallback onTap;
  const AboutContentWithData({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'About',
              style: whiteTextStyle.copyWith(
                fontSize: 14,
                fontWeight: bold,
              ),
            ),
            InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 17,
                  width: 17,
                  child: Image.asset('assets/edit.png'),
                ),
              ),
            ),
          ],
        ),
        // const Spacer(),
        const SizedBox(height: 33),
        const ItemLabelAbout(labelLeftText: 'Birthday:', labelRightText: '28 / 08 / 1995 (Age)'),
        const SizedBox(height: 15),
        const ItemLabelAbout(labelLeftText: 'Horoscope:', labelRightText: 'Virgo)'),
        const SizedBox(height: 15),
        const ItemLabelAbout(labelLeftText: 'Zodiac:', labelRightText: 'Pig)'),
        const SizedBox(height: 15),
        const ItemLabelAbout(labelLeftText: 'Height:', labelRightText: '175 cm)'),
        const SizedBox(height: 15),
        const ItemLabelAbout(labelLeftText: 'Weight:', labelRightText: '69 kg)'),
      ],
    );
  }
}

class EditAboutContent extends StatefulWidget {
  final VoidCallback onTap;

  const EditAboutContent({
    super.key,
    required this.onTap,
  });

  @override
  State<EditAboutContent> createState() => _EditAboutContentState();
}

class _EditAboutContentState extends State<EditAboutContent> {
  late SingleValueDropDownController _genderController;
  late TextEditingController _displayNameController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;

  String labelBirthday = 'DD MM YYYY';
  String labelZodiac = '--';
  String labelHoroscope = '--';

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
              onTap: widget.onTap,
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
        displayNameInput(),
        const SizedBox(height: 12),
        genderInput(),
        const SizedBox(height: 12),
        birthdayInput(context),
        const SizedBox(height: 12),
        horoscopeInput(),
        const SizedBox(height: 12),
        zodiacInput(),
        const SizedBox(height: 12),
        heightInput(),
        const SizedBox(height: 12),
        weightInput(),
      ],
    );
  }

  BaseInputLabel weightInput() {
    return BaseInputLabel(
      labelLeftText: 'Weight:',
      labelLeftStyle: whiteOpacity40TextStyle.copyWith(fontSize: 13, fontWeight: bold),
      enabled: true,
      textAlign: TextAlign.left,
      controller: _weightController,
      labelText: 'Add weight',
      labelStyle: whiteOpacity40TextStyle,
      hintText: 'Add weight',
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
      textInputType: TextInputType.number,
      textInputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly], // Onl
    );
  }

  BaseInputLabel heightInput() {
    return BaseInputLabel(
      labelLeftText: 'Height:',
      labelLeftStyle: whiteOpacity40TextStyle.copyWith(fontSize: 13, fontWeight: bold),
      enabled: true,
      textAlign: TextAlign.left,
      controller: _heightController,
      labelText: 'Add height',
      labelStyle: whiteOpacity40TextStyle,
      hintText: 'Add height',
      hintStyle: whiteOpacity40TextStyle,
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

  BaseInputLabel zodiacInput() {
    return BaseInputLabel(
      labelLeftText: 'Zodiac:',
      labelLeftStyle: whiteOpacity40TextStyle.copyWith(fontSize: 13, fontWeight: bold),
      enabled: false,
      textAlign: TextAlign.left,
      labelText: labelZodiac,
      labelStyle: whiteOpacity40TextStyle,
      hintText: labelZodiac,
      hintStyle: whiteOpacity40TextStyle,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your zodiac';
        }
        return null;
      },
    );
  }

  Row horoscopeInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Text(
            'Horoscope:',
            style: whiteOpacity40TextStyle.copyWith(fontSize: 13, fontWeight: bold),
          ),
        ),
        fetchHoroscopeInProgress
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Flexible(
                flex: 3,
                child: ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(width: 400, height: 200),
                  child: CustomTextField(
                      maxLines: 13,
                      collapsedInputDecoration: labelHoroscope.length > 2,
                      enabled: true,
                      textAlign: labelHoroscope.length > 2 ? TextAlign.center : TextAlign.start,
                      useBorderSide: true,
                      textEditingController: null,
                      labelText: labelHoroscope,
                      labelStyle: whiteOpacity40TextStyle.copyWith(overflow: TextOverflow.visible),
                      hintText: labelHoroscope,
                      hintStyle: whiteOpacity40TextStyle.copyWith(overflow: TextOverflow.visible),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select birthday too see your horoscope';
                        }
                        return null;
                      }),
                ),
              ),
      ],
    );
  }

  Row genderInput() {
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
            textFieldDecoration: aboutTextFieldDecoration,
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
            onChanged: (val) {},
          ),
        ),
      ],
    );
  }

  BaseInputLabel displayNameInput() {
    return BaseInputLabel(
        labelLeftText: 'Display name:',
        labelLeftStyle: whiteOpacity40TextStyle.copyWith(fontSize: 13, fontWeight: bold),
        textAlign: TextAlign.left,
        controller: _displayNameController,
        labelText: 'Enter name',
        labelStyle: whiteOpacity40TextStyle,
        hintText: 'Enter name',
        hintStyle: whiteOpacity40TextStyle,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your display name';
          }
          return null;
        });
  }

  BaseInputLabel birthdayInput(BuildContext context) {
    return BaseInputLabel(
      enabled: false,
      labelLeftText: 'Birthday:',
      labelLeftStyle: whiteOpacity40TextStyle.copyWith(
        fontSize: 13,
        fontWeight: bold,
      ),
      textAlign: TextAlign.left,
      labelText: labelBirthday,
      labelStyle: whiteTextStyle,
      hintText: labelBirthday,
      hintStyle: whiteOpacity40TextStyle,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your birthday';
        }
        return null;
      },
      onTap: () {
        // _handleDatePicker(context);
        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              background: backgroundColor,
              primary: backgroundColor3, // <-- SEE HERE
              onPrimary: white, // <-- SEE HERE
              onSurface: celestialBlue, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(primary: blueDowny // button text color
                  ),
            ),
          ),
          child: child!,
        );
      },
    );

    // log('selected date: ${selected!.day} ${selected!.month} ${selected!.year}');
    final int day = selected!.day;
    final int month = selected.month;
    final int year = selected.year;

    log('onpicker: $day $month $year');
    setState(() {
      fetchHoroscopeInProgress = true;
    });
    final result =
        await HTTPHoroscopeService().dailyPredictionPost(signZodiac: getZodiacSign(selected));

    result.fold((error) {
      Utils.createSnackBar(error, type: Severity.Error);
      setState(() {
        fetchHoroscopeInProgress = false;
      });
    }, (data) {
      var formattedDate = DateFormat('dd MM yyyy').format(selected);
      setState(() {
        labelBirthday = formattedDate;
        labelZodiac = getZodiacSign(selected);
        labelHoroscope = data;
        fetchHoroscopeInProgress = false;
      });
    });
  }
}
