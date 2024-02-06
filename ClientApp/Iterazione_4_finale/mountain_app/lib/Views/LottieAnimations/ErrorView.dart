import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mountain_app/Utilities/Misc.dart';
import 'package:mountain_app/Views/CutomButotns.dart';

// ignore: must_be_immutable
class ErrorView extends StatelessWidget {
  ErrorView({super.key, this.text, this.popLevel});

  String? text;
  int? popLevel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 0, 0, 0.1),
      body: Center(
        child: Container(
          height: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Lottie.asset(
                    "error.json",
                    repeat: true,
                    width: 200,
                    reverse: true,
                  ),
                  Lottie.network(
                    'https://raw.githubusercontent.com/FI-153/Progetto-PAC-2023-24/main/ClientApp/Iterazione_4_finale/mountain_app/assets/error.json',
                    repeat: true,
                    width: 200,
                    reverse: true,
                  ),
                ],
              ),
              Container(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text ?? "Si è verificato un errore...",
                      style: titolo,
                      textAlign: TextAlign.center,
                    ),
                    MainButton(
                      text: 'Ritenta',
                      width: 250,
                      borderRadius: 32,
                      color: Colors.red.shade700,
                      onPressed: () {
                        int count = 0;
                        Navigator.popUntil(
                            context, (_) => count++ >= (popLevel ?? 1));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
