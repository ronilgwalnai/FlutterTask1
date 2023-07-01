import 'package:flutter/material.dart';
import 'package:task/Routes/RouteGenerator.dart';
import 'package:task/Routes/RoutesPath.dart';

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
      initialRoute: RoutesPath.mainPage,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(0, 119, 150, 1.0)),
        useMaterial3: true,
      ),
    );
  }
}
