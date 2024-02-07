import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingAnimationView extends StatelessWidget {
  const LoadingAnimationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                children: [
                  Lottie.network(
                    'https://raw.githubusercontent.com/FI-153/Progetto-PAC-2023-24/main/ClientApp/Iterazione_4_finale/mountain_app/assets/mountainman.json',
                    height: 400,
                  ),
                  Lottie.asset(
                    'mountainman.json',
                    height: 400,
                  ),
                ],
              ),
              Text(
                "Caricando le tue escursioni...",
                style: TextStyle(fontSize: 20, color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
