import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_you_app/injection_container.dart';
import 'package:flutter_you_app/presentation/bloc/register_bloc.dart';
import 'package:flutter_you_app/presentation/widgets/register_form.dart';
import 'package:flutter_you_app/resource/theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
              stops: const <double>[0.1, 0.8, 10.0],
              colors: [
                backgroundColor,
                backgroundColor2,
                backgroundColor3.withOpacity(0),
              ],
            ),
          ),
          child: BlocProvider(
            create: (context) => sl<RegisterBloc>(),
            child: const RegisterForm(),
          ),         
        ),
      ),
    );
  }

  
}
