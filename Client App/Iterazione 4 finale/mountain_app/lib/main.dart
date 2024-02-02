import 'package:flutter/material.dart';
import 'package:mountain_app/Views/LottieAnimations/EmptyStateView.dart';
import 'package:mountain_app/Views/LottieAnimations/LoadingAnimationView.dart';
import 'package:mountain_app/Views/Login/LoginView.dart';
import 'package:mountain_app/Views/LottieAnimations/ErrorView.dart';
import 'package:mountain_app/Views/LottieAnimations/SuccessView.dart';
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
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromRGBO(244, 231, 187, 1),
            primary: Color.fromRGBO(235, 86, 0, 1),
            secondary: Color.fromRGBO(153, 140, 110, 1),
          ),
          fontFamily: "comfortaa",
        ),
        // home: HomepageScreen(),
        home: ErrorView(
          text: 'Si è verificato un errore...',
        )
        // home: LoginView(),
        );
  }
}
