import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_you_app/core/route/routes.dart';
import 'package:flutter_you_app/core/theme.dart';
import 'package:flutter_you_app/data/models/confirmation_password.dart';
import 'package:flutter_you_app/presentation/bloc/register_bloc.dart';
import 'package:flutter_you_app/presentation/pages/profile_page.dart';
import 'package:flutter_you_app/presentation/widgets/back_button_chevron.dart';
import 'package:flutter_you_app/presentation/widgets/custom_text_field.dart';
import 'package:flutter_you_app/presentation/widgets/primary_button.dart';
import 'package:formz/formz.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _form = GlobalKey<FormState>();

    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          debugPrint('RegisterFailure');
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        }
        if (state.status.isSuccess) {
          debugPrint('RegisterSuccess');
          // Navigator.of(context).pushReplacementNamed(Routes.profile);
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
              _UsernameInput(),
              _PasswordInput(),
              _ConfirmPasswordInput(),
              _RegisterButton(),
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
        Navigator.pop(context);
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
        'Register',
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
              Navigator.of(context).pushReplacementNamed(Routes.register);
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
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(bottom: largeMargin),
          child: CustomTextField(
            filledColor: const Color(0xFF243C41).withOpacity(1.0),
            textEditingController: emailController,
            labelText: 'Enter Email',
            labelStyle: whiteOpacity40TextStyle,
            hintText: 'Enter Email',
            hintStyle: whiteOpacity40TextStyle,
            onChanged: (value) => context.read<RegisterBloc>().add(RegisterEmailChanged(value!)),
            errorText: state.email.displayError != null ? 'Invalid Email' : null,
            errorStyle: whiteOpacity40TextStyle,
            textInputType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username/email';
              }
              return null;
            },
          ),
        );
      },
    );
  }
}

class _UsernameInput extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(bottom: largeMargin),
          child: CustomTextField(
            filledColor: const Color(0xFF243C41).withOpacity(1.0),
            textEditingController: emailController,
            labelText: 'Create Username',
            labelStyle: whiteOpacity40TextStyle,
            hintText: 'Create Username',
            hintStyle: whiteOpacity40TextStyle,
            onChanged: (value) => context.read<RegisterBloc>().add(RegisterUsernameChanged(value!)),
            errorText:
                state.username.displayError != null ? 'Invalid Username minimal 3 character' : null,
            errorStyle: whiteOpacity40TextStyle,
            textInputType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
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
    return BlocBuilder<RegisterBloc, RegisterState>(
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
            onChanged: (value) => context.read<RegisterBloc>().add(RegisterPasswordChanged(value!)),
            errorText: state.password.displayError != null
                ? 'Minimum 8 character, \nThe password consist of letter and number'
                : null,
            errorStyle: whiteOpacity40TextStyle,
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatefulWidget {
  @override
  State<_ConfirmPasswordInput> createState() => _ConfirmPasswordInputState();
}

class _ConfirmPasswordInputState extends State<_ConfirmPasswordInput> {
  TextEditingController passwordController = TextEditingController();
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) =>
          previous.confirmationPassword != current.confirmationPassword,
      builder: (context, state) {
        log('displayErrorConfirmationPass: ${state.confirmationPassword.displayError}');
        return Container(
          margin: const EdgeInsets.only(bottom: largeMargin),
          child: CustomTextField(
            filledColor: const Color(0xFF253D42),
            textEditingController: passwordController,
            labelText: 'Confirm password',
            labelStyle: whiteOpacity40TextStyle,
            hintText: 'Confirm password',
            hintStyle: whiteOpacity40TextStyle,
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
                return 'Please enter your confirmation password';
              }
              return null;
            },
            onChanged: (value) =>
                context.read<RegisterBloc>().add(RegisterConfirmationPasswordChanged(value!)),
            errorText: setErrorTextConfirmationPassword(state),
            errorStyle: whiteOpacity40TextStyle,
          ),
        );
      },
    );
  }

  String? setErrorTextConfirmationPassword(RegisterState state) {
    log('displayErrorPasswdConf: ${state.confirmationPassword.displayError}');
    if (state.confirmationPassword.displayError != null) {
      if (state.confirmationPassword.displayError == ConfirmationPasswordValidationError.notMatch) {
        return 'Confirmation Password not match with current passwor';
      } else if (state.confirmationPassword.displayError ==
          ConfirmationPasswordValidationError.invalid) {
        return 'Minimum 8 character, \nThe password consist of letter and number';
      }
    }
    return null;
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
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
                    title: 'Register',
                    height: 51.0,
                    radius: 9.0,
                    onPressed: state.isValid
                        ? () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            context.read<RegisterBloc>().add(RegisterPressed());
                          }
                        : null,
                  ),
                ),
              );
      },
    );
  }
}
