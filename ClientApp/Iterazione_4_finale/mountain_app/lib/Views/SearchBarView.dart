import 'package:flutter/material.dart';
import 'package:mountain_app/Models/Escursione.dart';
import 'package:mountain_app/Models/Utente.dart';
import 'package:mountain_app/Views/EventsGridView.dart';

class SearchBarView extends StatefulWidget {
  final List<Escursione> escursioni;

  const SearchBarView({super.key, required this.escursioni});

  @override
  State<SearchBarView> createState() => _SearchBarViewState();
}

class _SearchBarViewState extends State<SearchBarView> {
  late Utente utente;
  late List<Escursione> displayedEvents;

  @override
  void initState() {
    super.initState();
    displayedEvents = widget.escursioni;
    utente = Utente.loggedUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: SearchAnchor(
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
                            selectedIcon:
                                const Icon(Icons.brightness_2_outlined),
                          ),
                        )
                      ],
                    );
                  },
                  suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                    return List<ListTile>.generate(
                      widget.escursioni
                          .where((element) => element.nome
                              .toLowerCase()
                              .contains(controller.text.toLowerCase()))
                          .toList()
                          .length,
                      (index) {
                        return ListTile(
                          title: Text(widget.escursioni[index].nome),
                          onTap: () {
                            setState(() {
                              controller
                                  .closeView(widget.escursioni[index].nome);

                              displayedEvents = widget.escursioni
                                  .where((element) => element.nome
                                      .toLowerCase()
                                      .contains(controller.text.toLowerCase()))
                                  .toList();
                            });
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              eventDisplaySection()
            ],
          ),
        ),
      ),
    );
  }

  Widget eventDisplaySection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: SizedBox(
        height: 2000,
        child: EventsGridView(escursioni: displayedEvents),
      ),
    );
  }
}
