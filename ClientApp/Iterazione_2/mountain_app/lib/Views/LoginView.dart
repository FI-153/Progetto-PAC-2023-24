import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mountain_app/Models/Utente.dart';
import 'package:mountain_app/Screens/Homepage.dart';
import 'package:mountain_app/Utilities/Constants.dart';
import 'package:mountain_app/Views/RegistrationView.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController _usernameFieldController;
  late TextEditingController _passwordFieldcontroller;

  @override
  void initState() {
    super.initState();
    _usernameFieldController = TextEditingController();
    _passwordFieldcontroller = TextEditingController();
  }

  @override
  void dispose() {
    _usernameFieldController.dispose();
    _passwordFieldcontroller.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: SizedBox(
                height: 500,
                width: 350,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style: titolo,
                        ),
                        Text(
                          "Accedi per iniziare",
                          style: sottotitoloOpaco,
                        ),
                      ],
                    ),
                    Form(
                        key: _formKey,
                        child: Container(
                          height: 210,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 100,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Indirizzo Email",
                                        style: sottotitoloGrassetto,
                                      ),
                                      CustomTextField(
                                        Icons.mail_outline,
                                        "Inserisci la tua mail...",
                                        _usernameFieldController,
                                        false,
                                        TextInputType.name,
                                        true,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 100,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Password",
                                        style: sottotitoloGrassetto,
                                      ),
                                      CustomTextField(
                                        Icons.password_outlined,
                                        "Inserisci la tua password...",
                                        _passwordFieldcontroller,
                                        true,
                                        TextInputType.name,
                                        true,
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        )),
                    Center(
                        child: Column(children: [
                      Container(
                        height: 89,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FloatingActionButton(
                              child: Text(
                                "Accedi",
                                style: sottotitoloGrassetto,
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  String username =
                                      _usernameFieldController.text;
                                  String pass = _passwordFieldcontroller.text;
                                  print("Username: $username Password: $pass");
                                }

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomepageScreen(
                                      utente: Utente.utenteMock1,
                                    ),
                                  ),
                                );
                              },
                            ),
                            registestrationSection(),
                          ],
                        ),
                      ),
                    ])),
                  ],
                )))
      ],
    ));
  }

  Widget registestrationSection() {
    return RichText(
      text: TextSpan(
        style: sottotitolo,
        children: <TextSpan>[
          TextSpan(text: 'Oppure '),
          TextSpan(
              text: 'Registrati',
              style: sottotitoloLink,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrationView(),
                    ),
                  );
                }),
        ],
      ),
    );
  }
}
