import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_imc_calculator/components/constants.dart';
import 'package:flutter_imc_calculator/components/functions.dart';
import 'package:flutter_imc_calculator/pages/dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'IMC Calculator - Flutter',
      theme: ThemeData(
          errorColor: redLight,
          fontFamily: 'Login',
          backgroundColor: darkModeColor,
          brightness: Brightness.dark,
          primaryColor: stanColor,
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
              elevation: 0,
              scrolledUnderElevation: 0,
              centerTitle: true,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.light))),
      home: const DashboardPage(),
    );
  }
}
