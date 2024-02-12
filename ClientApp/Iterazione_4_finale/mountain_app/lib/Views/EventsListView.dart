import 'package:flutter/material.dart';
import 'package:mountain_app/Models/Escursione.dart';
import 'package:mountain_app/Views/EventDetailsView/EventDetailsView.dart';
import 'package:mountain_app/Views/LottieAnimations/EmptyStateView.dart';
import 'package:mountain_app/Views/TileView/TileView.dart';

class EventsListView extends StatelessWidget {
  const EventsListView({super.key, required this.escursioni});

  final List<Escursione> escursioni;

  @override
  Widget build(BuildContext context) {
    return escursioni.isEmpty
        ? EmptyStateView(text: 'Non ci sono escursioni...')
        : Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 500),
              child: ListView.builder(
                itemCount: escursioni.length,
                cacheExtent: 10000,
                itemBuilder: (context, index) => ListTile(
                  title: TileView(
                    escursione: escursioni[index],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EventDetailsView(escursione: escursioni[index]),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
  }
}
