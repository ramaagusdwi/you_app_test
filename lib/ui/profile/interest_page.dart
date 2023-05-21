import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_you_app/theme.dart';
import 'package:flutter_you_app/ui/widgets/back_button_chevron.dart';
import 'package:flutter_you_app/ui/widgets/custom_text_field.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class InterestPage extends StatelessWidget {
  const InterestPage({super.key});

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
            margin: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    back(),
                    save(),
                  ],
                ),
                SizedBox(height: 73.w),
                GradientText('Tell everyone about yourself',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: bold,
                    ),
                    colors: goldensColor),
                SizedBox(height: 12.w),
                Text(
                  'What interest you?',
                  style: whiteTextStyle.copyWith(fontSize: 20, fontWeight: bold),
                ),
                SizedBox(height: 35.w),
                interestInput(interestController)
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
          labelText: '',
          labelStyle: whiteOpacity40TextStyle,
          hintText: '',
          hintStyle: whiteOpacity40TextStyle,
          validator: (value) {
            return null;
          }),
    );
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

  Widget back() {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(top: 49, bottom: 60),
        child: Row(
          children: [
            BackButtonChevron(
              onBackPressed: () {},
              backButtonColor: white,
            ),
            Text(
              'Back',
              style: whiteTextStyle.copyWith(fontSize: 14, fontWeight: bold),
            ),
          ],
        ),
      ),
    );
  }
}
