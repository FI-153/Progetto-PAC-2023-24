import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mountain_app/Screens/Homepage.dart';
import 'package:mountain_app/Utilities/Misc.dart';
import 'package:mountain_app/Views/CutomButotns.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 255, 0, 0.009),
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
                    "checkmark.json",
                    repeat: false,
                    width: 200,
                    height: 200,
                  ),
                  Lottie.network(
                    'https://raw.githubusercontent.com/FI-153/Progetto-PAC-2023-24/main/ClientApp/Iterazione_4_finale/mountain_app/assets/checkmark.json',
                    repeat: false,
                    width: 200,
                    height: 200,
                  ),
                ],
              ),
              Container(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text,
                      style: titolo,
                      textAlign: TextAlign.center,
                    ),
                    MainButton(
                      text: 'Torna alla homepage',
                      width: 250,
                      borderRadius: 32,
                      color: Colors.green.shade500,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) {
                              return HomepageScreen();
                            }),
                          ),
                        );
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
