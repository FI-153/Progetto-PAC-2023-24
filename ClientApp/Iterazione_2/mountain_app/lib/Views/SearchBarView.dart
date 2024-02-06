import 'package:flutter/material.dart';
import 'package:mountain_app/Models/Escursione.dart';
import 'package:mountain_app/Models/Utente.dart';
import 'package:mountain_app/Screens/DestinationsScreen.dart';

class SearchBarView extends StatefulWidget {
  final List<Escursione> escursioni;
  final Utente utente;

  const SearchBarView(
      {super.key, required this.escursioni, required this.utente});

  @override
  State<SearchBarView> createState() =>
      _SearchBarViewState(escursioni: escursioni, utente: utente);
}

class _SearchBarViewState extends State<SearchBarView> {
  final List<Escursione> escursioni;
  final Utente utente;

  List<Escursione> displayedEvents = [];

  _SearchBarViewState({required this.escursioni, required this.utente});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            children: [
              SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    controller: controller,
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 16.0)),
                    onTap: () {
                      controller.openView();
                    },
                    leading: const Icon(Icons.search),
                    trailing: <Widget>[
                      Tooltip(
                        message: 'Filter',
                        child: IconButton(
                          onPressed: () {
                            setState(() {});
                          },
                          icon: const Icon(Icons.sort),
                          selectedIcon: const Icon(Icons.brightness_2_outlined),
                        ),
                      )
                    ],
                  );
                },
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                  List<Escursione> filtered = escursioni
                      .where((element) => element.nome
                          .toLowerCase()
                          .contains(controller.text.toLowerCase()))
                      .toList();

                  return List<ListTile>.generate(filtered.length, (index) {
                    return ListTile(
                      title: Text(escursioni[index].nome),
                      onTap: () {
                        setState(() {
                          controller.closeView(escursioni[index].nome);

                          displayedEvents = filtered;

                          print(displayedEvents.map((e) => e.nome));
                        });
                      },
                    );
                  });
                },
              ),
              eventDisplaySection()
            ],
          ),
        ),
      ),
    );
  }

  Padding eventDisplaySection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: SizedBox(
        height: 1000,
        child: DestinationsScreen(
          escursioni: displayedEvents,
          utente: utente,
        ),
      ),
    );
  }
}
