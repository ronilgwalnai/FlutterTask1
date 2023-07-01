import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/Helpers/Constants.dart';
import 'package:task/Helpers/HelperFunctions.dart';
import 'package:task/Routes/RoutesPath.dart';

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
        startNewPage(context, RoutesPath.mainPage, finishAll: true);
        // startNewPage(context, DemoPage(), finishCurrent: true);
      } else {
        startNewPage(context, RoutesPath.login, finishAll: true);
      }
    });
  }
}
