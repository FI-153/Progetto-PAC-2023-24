import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mountain_app/Views/Login/LoginView.dart';
import 'Screens/Homepage.dart';

void main() {
  // runApp(const MyApp(homepage: kDebugMode ? HomepageScreen() : LoginView()));
  runApp(const MyApp(homepage: HomepageScreen()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.homepage});

  final StatefulWidget homepage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mountains App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(244, 231, 187, 1),
          primary: Color.fromRGBO(235, 86, 0, 1),
          secondary: Color.fromRGBO(153, 140, 110, 1),
        ),
        fontFamily: "comfortaa",
      ),
      home: homepage,
    );
  }
}
