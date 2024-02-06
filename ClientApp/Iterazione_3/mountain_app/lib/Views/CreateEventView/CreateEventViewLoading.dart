import 'package:flutter/material.dart';
import 'package:mountain_app/Managers/EventsManager.dart';
import 'package:mountain_app/Models/Escursione.dart';
import 'package:mountain_app/Screens/Homepage.dart';

class CreateEventViewLoading extends StatefulWidget {
  const CreateEventViewLoading({super.key, required this.escursione});
  final Escursione escursione;

  @override
  State<CreateEventViewLoading> createState() => _CreateEventViewLoadingState();
}

class _CreateEventViewLoadingState extends State<CreateEventViewLoading> {
  late Future<Escursione> candidateEvent;

  @override
  void initState() {
    super.initState();
    candidateEvent = EventsManger().addEscursione(widget.escursione);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Escursione>(
          future: candidateEvent,
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              print("Failed");
              print(snapshot.error);
              //Navigator.pop(context);
            }

            if (snapshot.hasData) {
              print("Success");
              Future.microtask(() => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomepageScreen(),
                    ),
                  ));
            }

            return CircularProgressIndicator();
          })),
    );
  }
}
