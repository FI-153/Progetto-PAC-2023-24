import 'package:flutter/material.dart';
import 'package:mountain_app/Managers/EventsManager.dart';
import 'package:mountain_app/Models/Escursione.dart';
import 'package:mountain_app/Views/EventsListView.dart';
import 'package:mountain_app/Views/LottieAnimations/EmptyStateView.dart';
import 'package:mountain_app/Views/LottieAnimations/LoadingAnimationView.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  late Future<List<Escursione>> bookedEvents;

  @override
  void initState() {
    super.initState();
    bookedEvents = EventsManger().fetchBookedEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Escursione>>(
        future: bookedEvents,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          if (!snapshot.hasData) {
            return LoadingAnimationView();
          }

          List<Escursione> downEvents = snapshot.data!;

          if (downEvents.isEmpty) {
            return EmptyStateView(text: "Non ci sono iscrizioni...");
          } else {
            return EventsListView(escursioni: downEvents);
          }
        },
      ),
    );
  }
}
