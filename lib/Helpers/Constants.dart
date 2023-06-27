import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

mixin ImagesPath {
  static const String logo = 'asset/images/logo.png';
  static const String logo2 = 'asset/images/logo2.png';
  static const String background = 'asset/images/bg.svg';
  static const String help = 'asset/images/help.png';
  static Widget svg = SvgPicture.asset(background, semanticsLabel: 'Acme Logo');
}
mixin Strings {
  static const String whatDoYouEat = 'What Do You Eat';
  static const String addOns = 'Add-Ons';
  static const String enterOtp = 'Please Enter the Otp';
  static const String enterOtpCompletely = 'Please Enter the Valid Otp';
  static const String signIn = 'Sign In';
  static const String pleaseWait = 'Please Wait';
  static const String loading = 'Loading';
  static const String confirm = 'Confirm';
  static const String register = 'Register';
  static const String resendCode = 'Resend Code';
  static const String login = 'LOGIN';
  static const String otpEnterText = 'Please Enter the 4-digit code just send to your +91 ';
  static const String demoNumber = 'Ex: 9786435856';
  static const String numberLengthError = 'Phone Number Length Must me 10';
  static const String enterNumberText =
      'Please Enter the Phone Number for Verification';
  static const String dontHaveAccount = 'Don\'t Have an Account';
  static const String signInText =
      'Simply Enter your phone number to login or create an account';
  static const String placeMyOrder = 'Place My Order';
  static const String confirmation = 'Confirmation';
}
mixin Parms {
  static const String pincode = 'pincode';
  static const String mobile = 'mobile';
  static const String otp = 'code';
  static const String platformType = 'platform_type';
  static const String subscription_product_id = 'subscription_product_id';
}
mixin ResponseTypes {
  static const String valid = 'success';
  static const String invalid = 'invalid';
}
mixin SavedValues {
  static const String login = 'login';
  static const String invalid = 'invalid';
}
