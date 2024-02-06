import 'package:flutter/material.dart';
import 'package:mountain_app/Views/Login/LoginView.dart';
import 'Screens/Homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mountains App',
      theme: ThemeData(),
      home: HomepageScreen(),
      // home: LoginView(),
    );
  }
}
