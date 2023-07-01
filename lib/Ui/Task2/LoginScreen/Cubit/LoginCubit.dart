import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/Helpers/Constants.dart';
import 'package:task/Network/CallApi.dart';
import 'package:task/Routes/RoutesPath.dart';
import 'package:task/Ui/Task2/LoginScreen/Modals/LoginModel.dart';

import '../../../../Helpers/HelperFunctions.dart';
import '../../../../Network/Apis.dart';
import 'LoginCubitStates.dart';

class LoginCubit extends Cubit<LoginCubitStates> {
  LoginCubit() : super(InitialState());

  void loginClick(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      emit(ErrorState(error: Strings.enterNumberText));
    } else if (phoneNumber.length != 10) {
      emit(ErrorState(error: Strings.numberLengthError));
    } else {
      emit(ButtonLoading());
    }
  }

  MyApiCalls loginCall = MyApiCalls(url: Apis.loginTask2);

  void loginApiCall(BuildContext context, String phoneNumber) {
    var map = HashMap();
    map[Parms.mobile] = '9618599623';
    loginCall.postRequest(map, (response) {
      var jsonData = json.decode(response);
      var model = LoginModel.fromJson(jsonData);
      if (model.status == ResponseTypes.valid) {
        emit(LoginSuccessful());
        startNewPage(context, RoutesPath.otpVerification,
            finishCurrent: false, arguments: map[Parms.mobile]);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(model.message.toString()),
        ));
        emit(LoginFailed(error: model.message.toString()));
      }
    }, (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message.toString()),
      ));
      emit(LoginFailed(error: error.message.toString()));
    });
  }
}
