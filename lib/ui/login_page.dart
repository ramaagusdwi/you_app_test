import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_you_app/route/routes.dart';
import 'package:flutter_you_app/theme.dart';
import 'package:flutter_you_app/ui/widgets/back_button_chevron.dart';

import 'package:flutter_you_app/ui/widgets/custom_app_bar.dart';
import 'package:flutter_you_app/ui/widgets/custom_text_field.dart';
import 'package:flutter_you_app/ui/widgets/small_circular_loading.dart';
import 'package:flutter_you_app/ui/widgets/primary_button.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _form = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
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
          child: Form(
            key: _form,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(transform: Matrix4.translationValues(-10.0, 0.0, 0.0), child: back()),
                  header(),
                  emailInput(),
                  passwordInput(),
                  isLoading ? SmallCircularLoading() : signInButton(),
                  footer(),
                ],
              ),
            ),
          ),
        ),
      ),
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

  Widget header() {
    return Container(
      margin: const EdgeInsets.only(bottom: largeMargin, left: 16.0),
      child: Text(
        'Login',
        style: whiteTextStyle.copyWith(fontSize: 24, fontWeight: bold),
      ),
    );
  }

  Widget emailInput() {
    return Container(
      margin: const EdgeInsets.only(bottom: normalMargin),
      child: CustomTextField(
          filledColor: const Color(0xFF243C41).withOpacity(1.0),
          textEditingController: emailController,
          labelText: 'Enter Username/Email',
          labelStyle: whiteOpacity40TextStyle,
          hintText: 'Enter Username/Email',
          hintStyle: whiteOpacity40TextStyle,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your username/email';
            }
            return null;
          }),
    );
  }

  Widget passwordInput() {
    return Container(
      margin: const EdgeInsets.only(bottom: largeMargin),
      child: CustomTextField(
        filledColor: const Color(0xFF253D42),
        textEditingController: passwordController,
        labelText: 'Enter  password',
        labelStyle: whiteOpacity40TextStyle,
        hintText: 'Enter password',
        hintStyle: whiteOpacity40TextStyle,
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: white),
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
        ),
        obsureText: obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          return null;
        },
      ),
    );
  }

  Widget signInButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 50),
      child: Opacity(
        opacity: 0.4, //opacity 0.4 when username & password field not filled
        child: PrimaryButton(
          title: 'Login',
          height: 51.0,
          radius: 9.0,
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(Routes.profile);
          },
        ),
      ),
    );
  }

  Widget footer() {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No account? ',
            style: whiteTextStyle.copyWith(
              fontSize: 13,
              fontWeight: medium,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(Routes.register);
            },
            child: GradientText(
              'Register here',
              style: const TextStyle(
                fontSize: 13.0,
                decoration: TextDecoration.underline,
              ),
              colors: gradientColor,
            ),
          ),
        ],
      ),
    );
  }
}
