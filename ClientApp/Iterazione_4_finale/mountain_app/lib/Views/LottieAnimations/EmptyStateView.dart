import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyStateView extends StatelessWidget {
  const EmptyStateView({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Lottie.asset('/assets/empty.json', height: 400, repeat: false),
              Text(
                text,
                style: TextStyle(fontSize: 20, color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
