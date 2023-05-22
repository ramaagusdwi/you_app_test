import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_you_app/theme.dart';
import 'package:flutter_you_app/ui/widgets/back_button_chevron.dart';
import 'package:flutter_you_app/ui/widgets/custom_text_field.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class InterestPage extends StatefulWidget {
  const InterestPage({super.key});

  @override
  State<InterestPage> createState() => _InterestPageState();
}

class _InterestPageState extends State<InterestPage> {
  List<String> interests = [];
  int maxLines = 1; // Adjust this value as needed

  @override
  Widget build(BuildContext context) {
    final TextEditingController interestController = TextEditingController();

    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.0), // here the desired height
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            backgroundColor: backgroundColor,
          )),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(1.30, -0.8), // near the top right
              radius: 1.0,
              stops: <double>[0.1, 0.8, 10.0],
              colors: [
                backgroundColor,
                backgroundColor2,
                backgroundColor3.withOpacity(0),
              ],
            ),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 18.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 49.w),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    back(context),
                    save(),
                  ],
                ),
                SizedBox(height: 73.w),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: GradientText('Tell everyone about yourself',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: bold,
                      ),
                      colors: goldensColor),
                ),
                SizedBox(height: 12.w),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Text(
                    'What interest you?',
                    style: whiteTextStyle.copyWith(fontSize: 20, fontWeight: bold),
                  ),
                ),
                SizedBox(height: 35.w),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: interestInput(interestController),
                ),
                SizedBox(height: 20.w),
                if (interests.isNotEmpty) ...[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Text('Select Interest', style: whiteOpacity40TextStyle),
                  ),
                  SizedBox(height: 8.w),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Wrap(
                        direction: Axis.horizontal,
                        spacing: 4,
                        runSpacing: 8,
                        children: interests
                            .map((item) => Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: whiteOpacity10,
                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(item,
                                        style: whiteTextStyle.copyWith(
                                            fontSize: 12, fontWeight: semiBold)),
                                    SizedBox(width: 10.w),
                                    InkWell(
                                      onTap: () {
                                        interests.removeWhere((element) => element == item);
                                        setState(() {});
                                      },
                                      child: Icon(
                                        Icons.close,
                                        size: 14.w,
                                        color: white,
                                      ),
                                    )
                                  ],
                                )))
                            .toList()),
                  ),
                ], 
               
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget interestInput(TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: normalMargin),
      child: CustomTextField(
        filledColor: bgTextField2,
        textEditingController: controller,
        labelText: 'e.g Music',
        labelStyle: whiteOpacity40TextStyle,
        hintText: 'e.g Music',
        hintStyle: whiteOpacity40TextStyle,
        maxLines: maxLines,
        validator: (value) {
          return null;
        },
        onSubmitted: (value) {
          log('submitted');

          adjustTextFieldHeight(value!);
        },
      ),
    );
  }

  void adjustTextFieldHeight(String value) {
    interests.add(value);
    // final lines = value.split('\n').length;

    // // Set maximum number of lines
    // final maxLines = 5; // Adjust this value as needed
    final length = interests.length;
    setState(() {
      maxLines = length > 2 ? maxLines + 1 : maxLines;
    });
  }

  String setTextFieldLabel() {
    if (interests.isEmpty) return 'e.g Music';
    return '';
  }

  Widget save() {
    return GradientText(
      'Save',
      style: TextStyle(
        fontSize: 14.0,
        fontWeight: semiBold,
      ),
      colors: const [
        blueDowny,
        celestialBlue,
      ],
    );
  }

  Widget back(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pop(context);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BackButtonChevron(
            onBackPressed: () {
              Navigator.pop(context);
            },
            backButtonColor: white,
          ),
          Text(
            'Back',
            style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: bold),
          ),
        ],
      ),
    );
  }
}
