import 'package:flutter/material.dart';
import 'package:mountain_app/Models/Escursione.dart';
import 'package:mountain_app/Views/EventDetailsView/EventDetailsView.dart';
import 'package:mountain_app/Views/LottieAnimations/EmptyStateView.dart';
import 'package:mountain_app/Views/TileView/TileView.dart';

class EventsGridView extends StatelessWidget {
  const EventsGridView({super.key, required this.escursioni});

  final List<Escursione> escursioni;

  @override
  Widget build(BuildContext context) {
    return escursioni.isEmpty
        ? EmptyStateView(text: 'Non ci sono escursioni...')
        : Center(
            child: Container(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 220,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 0,
                    crossAxisCount:
                        (MediaQuery.sizeOf(context).width.round() / 500)
                            .floor()),
                itemCount: escursioni.length,
                itemBuilder: (context, index) => ListTile(
                  hoverColor: Color.fromRGBO(1, 1, 1, 0),
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
