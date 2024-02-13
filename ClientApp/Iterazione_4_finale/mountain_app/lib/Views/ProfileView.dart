import 'package:flutter/material.dart';
import 'package:mountain_app/Managers/EventsManager.dart';
import 'package:mountain_app/Managers/UserManager.dart';
import 'package:mountain_app/Models/Escursione.dart';
import 'package:mountain_app/Models/Utente.dart';
import 'package:mountain_app/Utilities/Misc.dart';
import 'package:mountain_app/Views/EventDetailsView/EventDetailsView.dart';
import 'package:mountain_app/Views/Login/LoginView.dart';
import 'package:mountain_app/Views/LottieAnimations/ErrorView.dart';
import 'package:mountain_app/Views/LottieAnimations/LoadingAnimationView.dart';
import 'package:mountain_app/Views/TileView/LoadingTileView.dart';
import 'package:mountain_app/Views/TileView/TileView.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key, required this.idUtente});

  final int idUtente;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late Future<Utente> utente;

  @override
  void initState() {
    super.initState();
    if (widget.idUtente == Utente.loggedUser.id) {
      utente = Future.value(Utente.loggedUser);
    } else {
      utente = UserManager().fetchUser(widget.idUtente);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Utente>(
        future: utente,
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return ErrorView(
              text: 'Non è stato possibile scaricare l\'utente...',
              popLevel: 1,
            );
          }

          if (!snapshot.hasData) {
            return LoadingAnimationView();
          }

          Utente downUtente = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              actions: [
                if (downUtente.id == Utente.loggedUser.id)
                  logoutButtonSection(context)
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    child: backgroundImageSection(),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        nameSurnameSection(
                                          downUtente.nome,
                                          downUtente.cognome,
                                        ),
                                        experienceSection(
                                          downUtente.esperienza,
                                        ),
                                        if (downUtente.isOrganizer)
                                          organizerSection(),
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
                  excursionListSection(context, downUtente),
                ],
              ),
            ),
          );
        }));
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

  Text experienceSection(double exp) {
    return Text(
      "Esperienza: " + exp.toString() + "/30",
      style: sottotitoloGrassetto,
    );
  }

  Widget excursionListSection(
    BuildContext context,
    Utente utente,
  ) {
    return utente.iscrizioniPassate.isEmpty
        ? Center(child: Text("Non ci sono esperienze passate."))
        : Center(
            child: Container(
              height: 900,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 220,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 0,
                    crossAxisCount:
                        (MediaQuery.sizeOf(context).width.round() / 500)
                            .floor()),
                itemCount: utente.iscrizioniPassate.length,
                itemBuilder: (context, index) {
                  return DownloadListTile(utente: utente, index: index);
                },
              ),
            ),
          );
  }

  Text nameSurnameSection(String name, String surname) {
    return Text(
      name + " " + surname,
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
