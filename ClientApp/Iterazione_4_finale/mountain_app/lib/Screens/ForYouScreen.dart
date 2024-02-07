import 'package:flutter/material.dart';
import 'package:mountain_app/Models/Escursione.dart';
import 'package:mountain_app/Models/Utente.dart';
import 'package:mountain_app/Views/EventsListView.dart';
import 'package:mountain_app/Views/LottieAnimations/EmptyStateView.dart';

class ForYouScreen extends StatefulWidget {
  final List<Escursione> escursioni;

  ForYouScreen({super.key, required this.escursioni}) {}

  @override
  State<ForYouScreen> createState() => _ForYouScreenState();
}

class _ForYouScreenState extends State<ForYouScreen> {
  late List<Escursione> suggestedEvents;

  @override
  void initState() {
    super.initState();
    suggestedEvents = widget.escursioni
        .where(
          (element) =>
              translateDifficulty(element.difficolta) <=
              Utente.loggedUser.esperienza,
        )
        .toList();
  }

  translateDifficulty(Difficolta difficolta) {
    switch (difficolta) {
      case Difficolta.easy:
        return 10;

      case Difficolta.medium:
        return 20;

      case Difficolta.hard:
        return 30;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (suggestedEvents.isEmpty)
      return EmptyStateView(text: "Non ci sono escursioni consigliate...");
    else
      return EventsListView(escursioni: suggestedEvents);
  }
}
