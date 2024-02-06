import 'package:flutter/material.dart';
import 'package:mountain_app/Managers/EventsManager.dart';
import 'package:mountain_app/Models/Escursione.dart';
import 'package:mountain_app/Models/Utente.dart';
import 'package:mountain_app/Utilities/Misc.dart';
import 'package:mountain_app/Views/CreateEventView/CreateEventView.dart';
import 'package:mountain_app/Views/CutomButotns.dart';
import 'package:mountain_app/Views/EventsListView.dart';
import 'package:mountain_app/Views/ProfileView.dart';
import 'ForYouScreen.dart';
import 'SubscriptionsScreen.dart';
import '../Views/SearchBarView.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  int currentPageIndex = 0;
  Utente utente = Utente.loggedUser;
  List<Escursione> downedEvents = [];

  late Future<List<Escursione>> escursioni;

  void fetchEscursioni() async {
    escursioni = EventsManger().fetchEvents();
  }

  @override
  void initState() {
    super.initState();
    fetchEscursioni();
  }

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
                          backgroundImage: AssetImage("images/meProfile.png"),
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
            Row(
              children: [refreshButtonSection(), searchButtonSection(context)],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        backgroundColor: Colors.green,
        hoverElevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32))),
        label: Text(
          "Nuova Escursione",
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
      body: FutureBuilder<List<Escursione>>(
        future: escursioni,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          downedEvents = snapshot.data!;

          return SafeArea(
            child: <Widget>[
              EventsListView(escursioni: downedEvents),
              SubscriptionsScreen(),
              ForYouScreen(escursioni: downedEvents),
            ][currentPageIndex],
          );
        },
      ),
    );
  }

  MenuButton refreshButtonSection() {
    return MenuButton(
      icon: Icons.refresh,
      iconSize: 30,
      onPressed: () {},
    );
  }

  MenuButton searchButtonSection(BuildContext context) {
    return MenuButton(
      icon: Icons.search,
      iconSize: 30,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SearchBarView(
              escursioni: downedEvents,
            ),
          ),
        );
      },
    );
  }
}
