import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_you_app/route/router.dart';
import 'package:flutter_you_app/ui/login_page.dart';
import 'package:flutter_you_app/route/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'You App',
    //   theme: ThemeData(
    //     primaryColor: Colors.black,
    //     // primarySwatch: Colors.grey,
    //   ),
    //   onGenerateRoute: generateRoute,
    //   home: const LoginPage(),
    // );
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'You App',
            theme: ThemeData(
              primaryColor: Colors.black,
              // primarySwatch: Colors.grey,
            ),
            onGenerateRoute: generateRoute,
            home: const LoginPage(),
          );
        });
  }
}
