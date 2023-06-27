import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/Helpers/Constants.dart';
import 'package:task/Ui/Task2/OtpVerificationScreen/OtpCubit/OtpStates.dart';

import '../../../../Network/Apis.dart';
import '../../../../Network/CallApi.dart';
import '../Models/OtpModel.dart';

class OtpCubit extends Cubit<OtpStates> {
  late SharedPreferences _preference;

  OtpCubit() : super(InitialStates()) {
    initPreference();
  }

  MyApiCalls otpVerificationCall = MyApiCalls(url: Apis.otpVerification);

  Future<void> otpVerification(
    BuildContext context,
    String otp,
    String number,
  ) async {
    emit(ShowLoadingDialogue());
    HashMap<String, String> hashMap = HashMap();
    hashMap[Parms.mobile] = '9618599623';
    hashMap[Parms.otp] = otp;
    hashMap[Parms.platformType] = 'android';
    otpVerificationCall.postRequest(hashMap, (response) {
      var jsonData = json.decode(response);
      var model = OtpModels.fromJson(jsonData);
      if (model.status == ResponseTypes.valid) {
        _preference.setBool(SavedValues.login, true);
        emit(VerificationSuccessfulState());
      } else {
        emit(VerificationFailedState(model.message));
      }
    }, (error) {
      emit(VerificationFailedState(error.message));
    });
  }

  void initPreference() async {
    _preference = await SharedPreferences.getInstance();
  }
}
