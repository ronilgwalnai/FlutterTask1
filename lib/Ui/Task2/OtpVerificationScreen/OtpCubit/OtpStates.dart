import 'package:task/Ui/Task2/OtpVerificationScreen/Models/OtpData.dart';

abstract class OtpStates {}

class InitialStates extends OtpStates {}

class ChangeCursorState extends OtpStates {}

class ShowLoadingDialogue extends OtpStates {}

class VerificationFailedState extends OtpStates {
  String? message;

  VerificationFailedState(this.message);
}

class VerificationSuccessfulState extends OtpStates {

}
