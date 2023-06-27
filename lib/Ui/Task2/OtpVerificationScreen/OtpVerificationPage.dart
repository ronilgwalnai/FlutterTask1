import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/Ui/Task2/OtpVerificationScreen/OtpCubit/OtpStates.dart';

import '../../../Helpers/Constants.dart';
import '../../../Helpers/HelperFunctions.dart';
import 'OtpCubit/OtpCubit.dart';

class OtpVerificationPage extends StatelessWidget {
  String number;
  String otp = '';

  OtpVerificationPage({required this.number, super.key});

  late OtpCubit myCubit;

  // Function to handle OTP input

  @override
  Widget build(BuildContext context) {
    myCubit = context.read<OtpCubit>();
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          ImagesPath.svg,
          BlocConsumer<OtpCubit, OtpStates>(listener: (blocContext, state) {
            if (state is ShowLoadingDialogue) {
              showDialogue(context);
            } else if (state is VerificationSuccessfulState) {
              cancelDialogue(context);
              startNewPage(context,  DemoPage(), finishAll: true);
            } else if (state is VerificationFailedState) {
              cancelDialogue(context);
              showSnackBar(context, state.message ?? "Some thing Went Wrong");
            }
          }, builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin:
                          const EdgeInsets.only(left: 60, right: 60, top: 150),
                      child: Image.asset(ImagesPath.logo2)),
                  const Row(
                    children: [
                      Text(
                        Strings.confirm,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    '${Strings.otpEnterText}$number',
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  OTPScreen(otpValue: (otpString) {
                    otp = otpString;
                  }),
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) =>
                                  const Color.fromRGBO(0, 119, 150, 1.0)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ))),
                      onPressed: () {
                        verifyForLogin(context);
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        child: Text(
                          Strings.login,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const Center(
                    child: Text(
                      Strings.resendCode,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Color.fromRGBO(14, 157, 185, 1.0)),
                    ),
                  ),
                ],
              ),
            );
          })
        ],
      ),
    ));
  }

  void verifyForLogin(BuildContext context) {
    if (otp.isEmpty) {
      showSnackBar(context, Strings.enterOtp);
    } else if (otp.length < 4) {
      showSnackBar(context, Strings.enterOtpCompletely);
    } else {
      myCubit.otpVerification(context, otp, number);
    }
  }
}

class OTPScreen extends StatefulWidget {
  Function(String otpString) otpValue;

  OTPScreen({required this.otpValue});

  @override
  _OTPScreenState createState() => _OTPScreenState(otpValue: otpValue);
}

class _OTPScreenState extends State<OTPScreen> {
  List<String> otp = List<String>.filled(4, ''); // List to store the OTP digits

  // Create a list of FocusNodes for each OTP box
  List<FocusNode> focusNodes =
      List<FocusNode>.generate(4, (index) => FocusNode());

  Function(String otpString) otpValue;

  _OTPScreenState({required this.otpValue});

  // Function to handle OTP input
  void handleOTPInput(String value, int index, BuildContext context) {
    var otpString = '';
    setState(() {
      otp[index] = value;
      for (var element in otp) {
        otpString = otpString + element;
      }
      otpValue(otpString);
    });

    if (value.isNotEmpty && index < otp.length - 1) {
      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(4, (index) {
            return SizedBox(
              width: 50.0,
              height: 50.0,
              child: TextField(
                autofocus: index == 0,
                focusNode: focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                onChanged: (value) => handleOTPInput(value, index, context),
                decoration: const InputDecoration(
                  counterText: '',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
