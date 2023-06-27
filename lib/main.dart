import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/Ui/Task2/MainScreen/Cubit/MainPageCubit.dart';

import 'Ui/Task2/MainScreen/MainPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(0, 119, 150, 1.0)),
        useMaterial3: true,
      ),
      // home: const MainPage(
      home: BlocProvider(
        create: (context) => MainPageCubit(),
        child:  MainPage(),
        //   create: (context) => productCubit(),
        //   child:  const ProductPage(),
      ),
    );
  }
}
