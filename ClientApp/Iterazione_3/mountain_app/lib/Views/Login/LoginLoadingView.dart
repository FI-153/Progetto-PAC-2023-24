import 'package:flutter/material.dart';
import 'package:mountain_app/Managers/UserManager.dart';
import 'package:mountain_app/Models/Utente.dart';
import 'package:mountain_app/Screens/Homepage.dart';

class LoginLoadingView extends StatefulWidget {
  const LoginLoadingView(
      {super.key, required this.username, required this.password});
  final String username;
  final String password;

  @override
  State<LoginLoadingView> createState() => _LoginLoadingViewState();
}

class _LoginLoadingViewState extends State<LoginLoadingView> {
  late Future<Utente> loggedUser;

  @override
  void initState() {
    super.initState();
    loggedUser = UserManager().login(widget.username, widget.password);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Utente>(
          future: loggedUser,
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              Navigator.pop(context);
            }

            if (snapshot.hasData) {
              Utente.loggedUser = snapshot.data!;

              Future.microtask(() => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomepageScreen(),
                    ),
                  ));
            }

            return CircularProgressIndicator();
          })),
    );
  }
}
