import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingTileView extends StatefulWidget {
  LoadingTileView({super.key});

  @override
  State<LoadingTileView> createState() => _LoadingTileViewState();
}

class _LoadingTileViewState extends State<LoadingTileView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Container(
        height: 220,
        width: double.infinity,
        child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              color: Color.fromRGBO(153, 140, 110, 0.3),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Lottie.network(
                        'https://raw.githubusercontent.com/FI-153/Progetto-PAC-2023-24/main/ClientApp/Iterazione_4_finale/mountain_app/assets/error.json',
                        height: 200,
                      ),
                      Lottie.asset(
                        'tileLoading.json',
                        height: 200,
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
