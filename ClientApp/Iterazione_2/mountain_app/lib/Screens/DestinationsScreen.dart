import 'package:flutter/material.dart';
import 'package:mountain_app/Models/Escursione.dart';
import 'package:mountain_app/Models/Utente.dart';
import 'package:mountain_app/Views/EventDetailsView.dart';
import 'package:mountain_app/Views/TileView.dart';

class DestinationsScreen extends StatelessWidget {
  final List<Escursione> escursioni;
  final Utente utente;
  const DestinationsScreen({
    Key? key,
    required this.escursioni,
    required this.utente,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: escursioni.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: TileView(escursione: escursioni[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventDetailsView(
                    escursione: escursioni[index],
                    listaEscursioni: Utente.utenteMock1.iscrizioni,
                    utente: utente,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
