import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/Helpers/Constants.dart';
import 'package:task/Helpers/HelperFunctions.dart';
import 'package:task/Ui/Task2/LoginScreen/loginPage.dart';

import '../LoginScreen/Cubit/LoginCubit.dart';
import '../MainScreen/MainPage.dart';

class SplashPage extends StatelessWidget {
  late SharedPreferences _preference;

  @override
  Widget build(BuildContext context) {
    checkValidation(context);
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> checkValidation(BuildContext context) async {
    _preference = await SharedPreferences.getInstance();
    Timer(const Duration(seconds: 2), () {
      if (_preference.getBool(SavedValues.login) == true) {
        startNewPage(context, DemoPage(), finishCurrent: true);
      } else {
        startNewPage(
            context,
            Hero(
              tag: "kartik",
              child: BlocProvider(
                create: (context) => LoginCubit(),
                child: loginPage(),
              ),
            ),
            finishAll: true);
      }
    });
  }
}
