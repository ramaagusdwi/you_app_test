import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_you_app/core/logger/simple_bloc_observer.dart';
import 'package:flutter_you_app/core/route/router.dart';
import 'package:flutter_you_app/presentation/bloc/about_bloc.dart';
import 'package:flutter_you_app/presentation/bloc/interest_bloc.dart';

import 'package:flutter_you_app/presentation/pages/login_page.dart';
import 'package:flutter_you_app/presentation/pages/profile_page.dart';

import 'injection_container.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();

  await configureDependencies();

  //bloc observer to log transitions and any errors.
  Bloc.observer = const SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => InterestBloc(),
              ),
              BlocProvider(
                create: (context) => AboutBloc(),
              ),
            ],
 
            child: MaterialApp(
              title: 'You App',
              theme: ThemeData(
                primaryColor: Colors.black,
              ),
              onGenerateRoute: generateRoute,
              // home: ProfilePage(username: 'test'),
              home: const LoginPage(),
            ),
          );
        });

  }
}
