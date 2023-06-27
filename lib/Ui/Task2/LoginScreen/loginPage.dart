import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/Helpers/Constants.dart';
import 'package:task/Ui/Task2/LoginScreen/Cubit/LoginCubit.dart';
import 'package:task/Ui/Task2/LoginScreen/Cubit/LoginCubitStates.dart';

class loginPage extends StatelessWidget {
  loginPage({super.key});

  late LoginCubit myCubit;
  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    myCubit = context.read<LoginCubit>();
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          ImagesPath.svg,
          Padding(
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
                      Strings.signIn,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                const Text(
                  Strings.signInText,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                const SizedBox(
                  height: 6,
                ),
                TextField(
                    keyboardType: TextInputType.number,
                    controller: numberController,
                    decoration: const InputDecoration(
                        hintText: Strings.demoNumber,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(),
                        ))),
                BlocBuilder<LoginCubit, LoginCubitStates>(
                    builder: (context, state) {
                  if (state is ErrorState) {
                    return Text(
                      state.error,
                      style: const TextStyle(fontSize: 20, color: Colors.red),
                    );
                  } else if (state is LoginFailed) {
                    return Text(
                      state.error,
                      style: const TextStyle(fontSize: 20, color: Colors.red),
                    );
                  }
                  return const SizedBox.shrink();
                }),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => const Color.fromRGBO(0, 119, 150, 1.0)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ))),
                    onPressed: () {
                      myCubit.loginClick(numberController.text);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 8),
                      child: BlocConsumer<LoginCubit, LoginCubitStates>(
                          listener: (context, states) {},
                          builder: (context, state) {
                            if (state is ButtonLoading) {
                              myCubit.loginApiCall(
                                  context, numberController.text);
                              return const CircularProgressIndicator(
                                color: Colors.white,
                              );
                            }
                            return const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 10),
                              child: Text(
                                Strings.login,
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Strings.dontHaveAccount,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      Strings.register,
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(14, 157, 185, 1.0)),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
