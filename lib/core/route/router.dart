import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_you_app/core/route/routes.dart';
import 'package:flutter_you_app/presentation/bloc/interest_bloc.dart';
import 'package:flutter_you_app/presentation/pages/login_page.dart';
import 'package:flutter_you_app/presentation/pages/interest_page.dart';
import 'package:flutter_you_app/presentation/pages/profile_page.dart';
import 'package:flutter_you_app/presentation/pages/register_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.profile:
      {
        // Cast the arguments to the correct
        // type: ScreenArguments.
        final args = settings.arguments as ProfilePageArgument;
        return MaterialPageRoute(
          builder: (_) => ProfilePage(username: args.username),
        ); // Pass
      }

    case Routes.register:
      return MaterialPageRoute(
        builder: (_) => const RegisterPage(),
      ); // Pass it

    case Routes.interest:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => InterestBloc(),
          child: InterestPage(),
        ),
      );

    default:
      //statements;
      return MaterialPageRoute(builder: (context) => const LoginPage());
  }
}
