import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_you_app/presentation/bloc/interest_bloc.dart';
import 'package:flutter_you_app/presentation/pages/interest_list_input.dart';
import 'package:flutter_you_app/shared_view/back_button_chevron.dart';
import 'package:flutter_you_app/resource/theme.dart';
import 'package:flutter_you_app/shared_view/custom_text_field.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class InterestInputPage extends StatefulWidget {
  const InterestInputPage({super.key});

  @override
  State<InterestInputPage> createState() => _InterestInputPageState();
}

class _InterestInputPageState extends State<InterestInputPage> {
  List<String> interests = [];
  int maxLines = 1; // Adjust this value as needed

  @override
  Widget build(BuildContext context) {
    final TextEditingController interestController = TextEditingController();

    return WillPopScope(
      onWillPop: () async {
        context.read<InterestBloc>().add(InterestRemovedAllTemp());
        return true;
      },
      child: Scaffold(
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
                      save(context, interestController),
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
                    child: _interestInputWidget(interestController, context),
                  ),
                  SizedBox(height: 20.w),
                  const InterestListInput(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _interestInputWidget(TextEditingController controller, BuildContext context) {
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
          context.read<InterestBloc>().add(InterestTextFieldSubmited(value!));
          controller.clear();
        },
      ),
    );
  }

  String setTextFieldLabel() {
    if (interests.isEmpty) return 'e.g Music';
    return '';
  }

  Widget save(BuildContext context, TextEditingController controller) {
    return InkWell(
      onTap: () {
        context.read<InterestBloc>().add(InterestSaved());
        Navigator.pop(context);
      },
      child: GradientText(
        'Save',
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: semiBold,
        ),
        colors: const [
          blueDowny,
          celestialBlue,
        ],
      ),
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
