import 'package:flutter/material.dart';
import 'package:mountain_app/Managers/UserManager.dart';
import 'package:mountain_app/Models/Utente.dart';
import 'package:mountain_app/Views/Login/LoginLoadingView.dart';
import 'package:mountain_app/Views/LottieAnimations/ErrorView.dart';

class RegistrationLoadingView extends StatefulWidget {
  const RegistrationLoadingView({super.key, required this.utente});
  final Utente utente;

  @override
  State<RegistrationLoadingView> createState() =>
      _RegistrationLoadingViewState();
}

class _RegistrationLoadingViewState extends State<RegistrationLoadingView> {
  late Future<Utente> candidateUser;

  @override
  void initState() {
    super.initState();
    candidateUser = UserManager().addUser(widget.utente);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Utente>(
          future: candidateUser,
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              Future.microtask(
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) {
                      return ErrorView(
                          text: "Registrazione fallita...", popLevel: 2);
                    }),
                  ),
                ),
              );
            }

            if (snapshot.hasData) {
              Utente nuovoUtente = snapshot.data!;

              //Per confermare l'avvenuta creazione dell'utente procediamo al login
              Future.microtask(
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginLoadingView(
                      username: nuovoUtente.mail,
                      password: nuovoUtente.password,
                    ),
                  ),
                ),
              );
            }

            return CircularProgressIndicator();
          })),
    );
  }
}
