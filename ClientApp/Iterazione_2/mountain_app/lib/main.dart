import 'package:flutter/material.dart';
import 'package:mountain_app/Models/Utente.dart';
import 'package:mountain_app/Views/LoginView.dart';
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
      home: HomepageScreen(utente: Utente.utenteMock1),
      // home: LoginView(),
    );
  }
}
