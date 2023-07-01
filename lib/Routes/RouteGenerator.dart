import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/Helpers/Animation/FadeAnimationRoute.dart';
import 'package:task/Routes/RoutesPath.dart';
import 'package:task/Ui/Task2/LoginScreen/Cubit/LoginCubit.dart';
import 'package:task/Ui/Task2/OtpVerificationScreen/OtpCubit/OtpCubit.dart';
import 'package:task/Ui/Task2/OtpVerificationScreen/OtpVerificationPage.dart';
import 'package:task/Ui/Task2/SplashScreen/SplashPage.dart';

import '../Ui/Task2/LoginScreen/loginPage.dart';
import '../Ui/Task2/MainScreen/Cubit/MainPageCubit.dart';
import '../Ui/Task2/MainScreen/MainPage.dart';
import '../Ui/Task2/ProductCategories/ProductCategoryPage.dart';

class RouteGenerator {
  static PageRouteBuilder generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    late Widget page;
    switch (settings.name) {
      case RoutesPath.splash:
        page = SplashPage();
      case RoutesPath.category:
        page =  ProductCategoryPage();
      case RoutesPath.otpVerification:
        page = BlocProvider(
          create: (context) => OtpCubit(),
          child: OtpVerificationPage(number: args.toString()),
        );

      case RoutesPath.login:
        page = BlocProvider(
          create: (context) => LoginCubit(),
          child: loginPage(),
        );

      case RoutesPath.mainPage:
        page = BlocProvider(
          create: (context) => MainPageCubit(),
          child: MainPage(),
        );

      default:
        page = Scaffold(
          body: const Center(
            child: Text(
                'Something Wired Happened here and we are looking for the cause!!'),
          ),
          appBar: AppBar(
            title: const Text('Error'),
          ),
        );
    }
    return ScaleTransition2(page);
  }
}
