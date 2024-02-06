import 'package:flutter/material.dart';
import 'package:mountain_app/Managers/EventsManager.dart';
import 'package:mountain_app/Models/Escursione.dart';
import 'package:mountain_app/Views/LottieAnimations/ErrorView.dart';
import 'package:mountain_app/Views/LottieAnimations/SuccessView.dart';

class CreateEventViewLoading extends StatefulWidget {
  const CreateEventViewLoading({super.key, required this.escursione});
  final Escursione escursione;

  @override
  State<CreateEventViewLoading> createState() => _CreateEventViewLoadingState();
}

class _CreateEventViewLoadingState extends State<CreateEventViewLoading> {
  late Future<bool> result;

  @override
  void initState() {
    super.initState();
    result = EventsManger().addEscursione(widget.escursione);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<bool>(
          future: result,
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              Future.microtask(
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) {
                      return ErrorView(popLevel: 2);
                    }),
                  ),
                ),
              );
            }

            if (snapshot.hasData) {
              Future.microtask(
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) {
                      return SuccessView(text: "Evento creato!");
                    }),
                  ),
                ),
              );
            }

            return CircularProgressIndicator();
          })),
    );
  }
}
