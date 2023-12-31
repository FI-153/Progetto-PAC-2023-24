import 'package:flutter/material.dart';
import 'package:mountain_app/Models/Escursione.dart';
import 'package:mountain_app/Views/EventDetailsView.dart';
import 'package:mountain_app/Views/TileView.dart';

class DestinationsScreen extends StatelessWidget {
  final List<Escursione> escursioni;
  const DestinationsScreen({
    Key? key,
    required this.escursioni,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: escursioni.length,
        itemBuilder: (context, index) {
          // return TileView(escursione: escursioni[index]);
          return ListTile(
            title: TileView(escursione: escursioni[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EventDetailsView(escursione: escursioni[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}