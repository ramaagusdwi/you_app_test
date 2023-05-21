import 'package:flutter/material.dart';
import 'package:flutter_you_app/route/routes.dart';
import 'package:flutter_you_app/ui/login_page.dart';
import 'package:flutter_you_app/ui/profile/interest_page.dart';
import 'package:flutter_you_app/ui/profile/profile_page.dart';
import 'package:flutter_you_app/ui/register_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.profile:
      return MaterialPageRoute(
        builder: (_) => const ProfilePage(),
      ); // Pass it

    case Routes.register:
      return MaterialPageRoute(
        builder: (_) => const RegisterPage(),
      ); // Pass it

    case Routes.interest:
      return MaterialPageRoute(
        builder: (_) => const InterestPage(),
      ); 

    default:
      //statements;
      return MaterialPageRoute(builder: (context) => LoginPage());
  }
}
