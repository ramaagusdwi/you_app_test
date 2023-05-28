import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_you_app/core/route/routes.dart';
import 'package:flutter_you_app/domain/entities/about_data.dart';
import 'package:flutter_you_app/domain/entities/login_entity.dart';
import 'package:flutter_you_app/presentation/bloc/about_bloc.dart';
import 'package:flutter_you_app/presentation/bloc/login_bloc.dart';
import 'package:flutter_you_app/presentation/pages/profile_page.dart';
import 'package:flutter_you_app/resource/theme.dart';
import 'package:flutter_you_app/shared_view/back_button_chevron.dart';
import 'package:flutter_you_app/shared_view/custom_text_field.dart';
import 'package:flutter_you_app/shared_view/primary_button.dart';
import 'package:formz/formz.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:flutter_you_app/extension/snackbar_ext.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _form = GlobalKey<FormState>();

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          debugPrint('loginFailure');
          context.buildErrorSnackBar(state.errorMessage ?? 'Failed Login!!!!');
        }
        if (state.status.isSuccess) {
          context
              .read<AboutBloc>()
              .add(AboutAddData(aboutData: AboutData(displayName: state.email.value)));
          Navigator.pushReplacementNamed(
            context,
            Routes.profile,
            arguments: ProfilePageArgument(
              state.email.value, // 'username' or passwd
            ),
          );
        }
      },
      child: Form(
        key: _form,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _back(context),
              _header(),
              _EmailInput(),
              _PasswordInput(),
              _LoginButton(),
              _footer(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _back(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.pop(context);
      },
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

  Widget _header() {
    return Container(
      margin: const EdgeInsets.only(bottom: largeMargin, left: 16.0),
      child: Text(
        'Login',
        style: whiteTextStyle.copyWith(fontSize: 24, fontWeight: bold),
      ),
    );
  }

  Widget _footer(BuildContext context) {
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
              Navigator.of(context).pushNamed(Routes.register);
            },
            child: GradientText(
              'Register here',
              style: const TextStyle(
                fontSize: 13.0,
                decoration: TextDecoration.underline,
              ),
              colors: goldensColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(bottom: largeMargin),
          child: CustomTextField(
            filledColor: const Color(0xFF243C41).withOpacity(1.0),
            useBorderSide: false,
            textEditingController: emailController,
            labelText: 'Enter Email',
            labelStyle: whiteOpacity40TextStyle,
            hintText: 'Enter Email',
            hintStyle: whiteOpacity40TextStyle,
            onChanged: (value) => context.read<LoginBloc>().add(LoginEmailChanged(value!)),
            errorText: state.email.displayError != null ? 'Invalid Email' : null,
            errorStyle: whiteOpacity40TextStyle,
            textInputType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatefulWidget {
  @override
  State<_PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  TextEditingController passwordController = TextEditingController();
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(bottom: largeMargin),
          child: CustomTextField(
            filledColor: const Color(0xFF253D42),
            textEditingController: passwordController,
            labelText: 'Enter  password',
            labelStyle: whiteOpacity40TextStyle,
            hintText: 'Enter password',
            hintStyle: whiteOpacity40TextStyle,
            useBorderSide: false,
            suffixIcon: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: goldensColor,
                ).createShader(bounds);
              },
              child: IconButton(
                icon: Icon(obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: white),
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              ),
            ),
            obsureText: obscureText,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
            onChanged: (value) => context.read<LoginBloc>().add(LoginPasswordChanged(value!)),
            errorText: state.password.displayError != null
                ? 'Minimum 8 character, only letter and number'
                : null,
            errorStyle: whiteOpacity40TextStyle,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const Center(
                child: Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: CircularProgressIndicator(),
              ))
            : Container(
                margin: const EdgeInsets.only(bottom: 50),
                child: Opacity(
                  opacity: state.isValid
                      ? 1.0
                      : 0.4, //opacity 0.4 when username & password field is not valid
                  child: PrimaryButton(
                    title: 'Login',
                    height: 51.0,
                    radius: 9.0,
                    onPressed: state.isValid
                        ? () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            log('email: ${state.email.value}, passwd: ${state.password.value}');
                            final loginEntity = LoginEntity(
                                email: state.email.value, password: state.password.value);
                            context.read<LoginBloc>().add(LoginPressed(loginEntity));
                          }
                        : null,
                  ),
                ),
              );
      },
    );
  }
}
