import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mountain_app/Managers/EventsManager.dart';
import 'package:mountain_app/Managers/WeatherManager.dart';
import 'package:mountain_app/Models/Escursione.dart';
import 'package:mountain_app/Models/Utente.dart';
import 'package:mountain_app/Models/WeatherConditions.dart';
import 'package:mountain_app/Utilities/Misc.dart';
import 'package:mountain_app/Views/CutomButotns.dart';
import 'package:mountain_app/Views/EventDetailsView/LoadingSubscibeEventDetailsView.dart';

class EventDetailsView extends StatefulWidget {
  final Escursione escursione;

  EventDetailsView({super.key, required this.escursione});

  @override
  State<EventDetailsView> createState() => _EventDetailsViewState();
}

class _EventDetailsViewState extends State<EventDetailsView> {
  Utente utente = Utente.loggedUser;

  late Future<WeatherConditions> weather;

  @override
  void initState() {
    super.initState();
    weather = WeatherManager()
        .fetchWeather(widget.escursione.data, widget.escursione.luogo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Image(image: AssetImage("images/Tagliaferri.jpg")),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.escursione.luogo, style: luogo),
                          Text(widget.escursione.nome, style: titolo),
                          Text(widget.escursione.data, style: data),
                        ],
                      ),
                    ],
                  ),
                  customDivider(),
                  SizedBox(
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Condizioni meteo",
                          style: sottotitoloGrassetto,
                        ),
                        Center(
                          child: FutureBuilder<WeatherConditions>(
                              future: weather,
                              builder: ((context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text(
                                    "Condizioni meteo al momento non disponibili...",
                                    textAlign: TextAlign.center,
                                  );
                                }

                                if (!snapshot.hasData) {
                                  return CircularProgressIndicator();
                                }

                                var weatherCond = snapshot.data!;
                                return SizedBox(
                                    width: 500,
                                    child: Text(
                                      weatherCond.description,
                                      textAlign: TextAlign.center,
                                    ));
                              })),
                        )
                      ],
                    ),
                  ),
                  customDivider(),
                  SizedBox(
                    height: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            gridElement("Distanza", widget.escursione.distanza),
                            gridElement(
                                "Dislivello", widget.escursione.dislivello),
                            gridElement("Tempo", widget.escursione.tempo)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            gridElement(
                                "Altezza Max.", widget.escursione.altMax),
                            gridElement(
                                "Altezza Min.", widget.escursione.altMin),
                            gridElement(
                                "Difficoltà", widget.escursione.difficolta.name)
                          ],
                        )
                      ],
                    ),
                  ),
                  customDivider(),
                  SizedBox(
                    height: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 110,
                              child: Text("Organizzatore > ",
                                  style: sottotitoloGrassetto),
                            ),
                            showListOfPeople(
                                [widget.escursione.idOrganizzatore], 1)
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 110,
                              child: Text("Partecipanti > ",
                                  style: sottotitoloGrassetto),
                            ),
                            showListOfPeople(List.filled(10, 0), 4)
                          ],
                        ),
                      ],
                    ),
                  ),
                  customDivider(),
                  CustomInset(Text("Descrizione Percorso",
                      style: sottotitoloGrassetto)),
                  displayTextParagraph(widget.escursione.descrizione),
                  customDivider(),
                  Text("Strumentazione Richiesta", style: sottotitoloGrassetto),
                  displayTextParagraph(widget.escursione.strumentazione),
                  customDivider(),
                  Text("Ritrovo", style: sottotitoloGrassetto),
                  CustomInset(Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Orario: ", style: sottotitoloGrassetto),
                          Text(widget.escursione.oraRitrovo)
                        ],
                      ),
                      Row(
                        children: [
                          Text("Luogo: ", style: sottotitoloGrassetto),
                          Text(widget.escursione.luogoRitrovo)
                        ],
                      ),
                    ],
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (isUserSubscribed())
                    unsubscribeButtonSection()
                  else
                    subscribeButtonSection(),
                  if (widget.escursione.idOrganizzatore == Utente.loggedUser.id)
                    Column(
                      children: [
                        deleteEventSection(context),
                      ],
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget algorithmButtonSection() {
    return MainButton(
      text: 'Seleziona partecipanti',
      width: 250,
      borderRadius: 30,
      color: Colors.green,
      onPressed: () {},
    );
  }

  Widget deleteEventSection(BuildContext context) {
    return MainButton(
      color: Colors.red,
      text: "Cancella evento",
      width: 250,
      borderRadius: 30,
      onPressed: () {
        int idEvento = widget.escursione.id;
        EventsManger().deleteEvent(idEvento);
        Navigator.pop(context);
      },
    );
  }

  Widget subscribeButtonSection() {
    return MainButton(
      text: 'Prenotati a questa escursione',
      width: 250,
      borderRadius: 30,
      color: Colors.green,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoadingSubscribeEventDetailsView(
              idEvent: widget.escursione.id,
            ),
          ),
        );
      },
    );
  }

  Widget unsubscribeButtonSection() {
    return MainButton(
      color: Colors.green,
      borderRadius: 30,
      width: 250,
      text: 'Disiscriviti da questa escursione',
    );
  }

  Widget displayTextParagraph(String textToDiplay) {
    return CustomInset(
      Text(textToDiplay, textAlign: TextAlign.justify),
    );
  }

  Widget CustomInset(Widget toInset) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: toInset,
    );
  }

  Widget showListOfPeople(List<int> people, int maxPeopleToDisplay) {
    int excessPeople = 0;
    if (people.length >= maxPeopleToDisplay) {
      excessPeople = people.length - maxPeopleToDisplay;
    }

    return Row(
      children: [
        Row(
          children: List.generate(
            (excessPeople == 0) ? people.length : maxPeopleToDisplay,
            (index) => personFaceView(people[index]),
          ),
        ),
        if (excessPeople > 0) personFaceView(null, excessPeople)
      ],
    );
  }

  Widget personFaceView([int? userId, int? number]) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
      child: (userId != null)
          ? CircleAvatar(
              foregroundImage:
                  AssetImage("images/me${Random().nextInt(4) + 1 % 4}.png"))
          : CircleAvatar(child: Text("+$number")),
    );
  }

  Widget gridElement(String title, String text) {
    return Container(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title),
          Text(
            text,
            style: sottotitoloGrassetto,
          ),
        ],
      ),
    );
  }

  bool isUserSubscribed() {
    if (Utente.loggedUser.iscrizioni.contains(widget.escursione.id))
      return true;
    return false;
  }

  final TextStyle luogo = const TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontSize: 20,
  );

  final TextStyle data = const TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontSize: 15,
  );
}
