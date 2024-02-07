import 'package:flutter/material.dart';
import 'package:mountain_app/Models/Escursione.dart';
import 'package:mountain_app/Models/Utente.dart';
import 'package:mountain_app/Utilities/Constants.dart';
import 'package:mountain_app/Views/CreateEventView.dart';
import 'package:mountain_app/Views/ProfileView.dart';
import 'DestinationsScreen.dart';
import 'ForYouScreen.dart';
import 'SubscriptionsScreen.dart';
import '../Views/SearchBarView.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key, required this.utente}) : super(key: key);
  final Utente utente;

  @override
  State<HomepageScreen> createState() => _HomepageScreenState(utente: utente);
}

class _HomepageScreenState extends State<HomepageScreen> {
  int currentPageIndex = 0;
  final Utente utente;

  _HomepageScreenState({required this.utente});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                  // child: CircleAvatar(
                  //   backgroundImage: AssetImage("images/me.jpg"),
                  //   radius: 30,
                  // ),
                  child: Container(
                    width: 60,
                    height: 60,
                    child: FloatingActionButton.extended(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProfileView(utente: this.utente),
                            ),
                          );
                        },
                        shape: CircleBorder(),
                        label: CircleAvatar(
                          backgroundImage: AssetImage("images/me.jpg"),
                          radius: 30,
                        )),
                  ),
                ),
                Text(
                  ("Ciao, " + utente.nome),
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23),
                ),
              ],
            ),
            FloatingActionButton.extended(
              elevation: 0,
              backgroundColor: Colors.green,
              hoverElevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32))),
              label: Text(
                "Crea Evento",
                style: sottotitoloGrassetto,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CreateEventView(),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.search),
              iconSize: 30,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SearchBarView(
                      escursioni: Escursione.escursioniMock,
                      utente: utente,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.explore_outlined),
              label: "Destinazioni",
              selectedIcon: Icon(Icons.explore),
            ),
            NavigationDestination(
              icon: Icon(Icons.tour_outlined),
              label: "Iscrizioni",
              selectedIcon: Icon(Icons.tour),
            ),
            NavigationDestination(
              icon: Icon(Icons.tips_and_updates_outlined),
              label: "Per Te",
              selectedIcon: Icon(Icons.tips_and_updates),
            )
          ]),
      body: SafeArea(
        child: <Widget>[
          DestinationsScreen(
            escursioni: Escursione.escursioniMock,
            utente: utente,
          ),
          SubscriptionsScreen(),
          ForYouScreen(),
        ][currentPageIndex],
      ),
    );
  }
}
