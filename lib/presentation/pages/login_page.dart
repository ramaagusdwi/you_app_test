import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_you_app/resource/theme.dart';
import 'package:flutter_you_app/injection_container.dart';
import 'package:flutter_you_app/presentation/bloc/login_bloc.dart';
import 'package:flutter_you_app/presentation/widgets/login_form.dart';

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
            child: BlocProvider(
              create: (_) => sl<LoginBloc>(),
              child: const LoginForm(),
            )
            
            ),
      ),
    );
  }



 
}
