import 'package:flutter/material.dart';
import 'package:mountain_app/Managers/EventsManager.dart';
import 'package:mountain_app/Models/Escursione.dart';
import 'package:mountain_app/Models/Utente.dart';
import 'package:mountain_app/Utilities/Misc.dart';
import 'package:mountain_app/Views/EventDetailsView/EventDetailsView.dart';
import 'package:mountain_app/Views/Login/LoginView.dart';
import 'package:mountain_app/Views/TileView/LoadingTileView.dart';
import 'package:mountain_app/Views/TileView/TileView.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.utente});

  final Utente utente;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (utente.id == Utente.loggedUser.id) logoutButtonSection(context)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 160,
              child: Stack(
                children: [
                  backgroundImageSection(),
                ],
              ),
            ),
            Container(
              height: 180,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            profilePhotoView(),
                            SizedBox(
                              height: 90,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  nameSurnameSection(),
                                  experienceSection(),
                                  if (utente.isOrganizer) organizerSection(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        customDivider(),
                        Text(
                          "Esperienze Passate",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            excursionListSection(),
          ],
        ),
      ),
    );
  }

  IconButton logoutButtonSection(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.logout),
      iconSize: 25,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginView()),
        );
      },
    );
  }

  Text experienceSection() {
    return Text(
      "Esperienza: " + utente.esperienza.toString() + "/30",
      style: sottotitoloGrassetto,
    );
  }

  Widget excursionListSection() {
    return utente.iscrizioniPassate.isEmpty
        ? Center(child: Text("Non ci sono esperienze passate."))
        : Container(
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
      padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
      child: CircleAvatar(
        radius: 60,
        foregroundImage: AssetImage('images/meProfile.png'),
      ),
    );
  }

  Image backgroundImageSection() {
    return Image(
      fit: BoxFit.fitWidth,
      height: 170,
      width: double.infinity,
      image: AssetImage("images/mountain2.png"),
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
              print(snapshot.error.toString());
              return SizedBox(height: 0);
            }

            if (!snapshot.hasData) {
              return LoadingTileView();
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
                    ),
                  ),
                );
              },
            );
          })),
    );
  }
}
