import 'package:flutter/material.dart';
import 'package:mountain_app/Managers/EventsManager.dart';
import 'package:mountain_app/Models/Escursione.dart';
import 'package:mountain_app/Models/Utente.dart';
import 'package:mountain_app/Utilities/Constants.dart';
import 'package:mountain_app/Views/EventDetailsView.dart';
import 'package:mountain_app/Views/Login/LoginView.dart';
import 'package:mountain_app/Views/TileView.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.utente});

  final Utente utente;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          icon: Icon(Icons.logout),
          iconSize: 25,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginView()),
            );
          },
        ),
      ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              backgroundImageSection(),
              profilePhotoView(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                nameSurnameSection(),

                //Only show if it is organizer
                if (utente.isOrganizer) organizerSection(),

                customDivider(),

                Text(
                  "Esperienze Passate",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),

                excursionListSection(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget excursionListSection() {
    return Container(
      height: 900,
      child: ListView.builder(
        itemCount: utente.iscrizioniPassate.length,
        itemBuilder: (context, index) {
          return DownloadListTile(utente: utente, index: index);
        },
      ),
    );
  }

  Text nameSurnameSection() {
    return Text(
      utente.nome + " " + utente.cognome,
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
    );
  }

  Row organizerSection() {
    return Row(
      children: [
        Container(
          width: 130,
          child: Text(
            "Organizzatore",
            style: sottotitoloOpaco,
          ),
        ),
      ],
    );
  }

  Widget profilePhotoView() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 64, 16, 16),
      child: CircleAvatar(
        radius: 70,
        foregroundImage: AssetImage('images/me.jpg'),
      ),
    );
  }

  Container backgroundImageSection() {
    return Container(
      width: 1000,
      child: Image(
          fit: BoxFit.fill, image: AssetImage("images/profileBackground.jpg")),
    );
  }
}

class DownloadListTile extends StatefulWidget {
  const DownloadListTile({
    super.key,
    required this.utente,
    required this.index,
  });

  final Utente utente;
  final int index;

  @override
  State<DownloadListTile> createState() => _DownloadListTileState();
}

class _DownloadListTileState extends State<DownloadListTile> {
  late Future<Escursione> escursione;

  @override
  void initState() {
    super.initState();
    fetchEvent();
  }

  void fetchEvent() async {
    escursione = EventsManger()
        .fetchEvent(Utente.loggedUser.iscrizioniPassate[widget.index]);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Escursione>(
          future: escursione,
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            Escursione downEscursione = snapshot.data!;

            return ListTile(
              title: TileView(escursione: downEscursione),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventDetailsView(
                      escursione: downEscursione,
                      listaEscursioni: widget.utente.iscrizioni,
                    ),
                  ),
                );
              },
            );
          })),
    );
  }
}
