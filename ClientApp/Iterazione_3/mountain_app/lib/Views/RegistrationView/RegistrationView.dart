import 'package:flutter/material.dart';
import 'package:mountain_app/Models/Utente.dart';
import 'package:mountain_app/Utilities/Misc.dart';
import 'package:mountain_app/Views/CreateEventView/CustomTextFields.dart';
import 'package:mountain_app/Views/RegistrationView/RegistrationLoadingView.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  late TextEditingController _nameFieldController;
  late TextEditingController _surnnameFieldController;
  late TextEditingController _passwordFieldcontroller;
  late TextEditingController _emailFieldcontroller;
  late TextEditingController _phoneFieldcontroller;
  late TextEditingController _codeFieldcontroller;

  @override
  void initState() {
    super.initState();
    _nameFieldController = TextEditingController();
    _surnnameFieldController = TextEditingController();
    _emailFieldcontroller = TextEditingController();
    _phoneFieldcontroller = TextEditingController();
    _codeFieldcontroller = TextEditingController();
    _passwordFieldcontroller = TextEditingController();
  }

  @override
  void dispose() {
    _nameFieldController.dispose();
    _surnnameFieldController.dispose();
    _emailFieldcontroller.dispose();
    _phoneFieldcontroller.dispose();
    _codeFieldcontroller.dispose();
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
                height: 850,
                width: 350,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    titleSection(),
                    Form(
                        key: _formKey,
                        child: Container(
                          height: 660,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                customTextFieldSection(
                                  Icons.person,
                                  "Nome",
                                  "Inserisci il tuo nome...",
                                  _nameFieldController,
                                  true,
                                  false,
                                  TextInputType.name,
                                  false,
                                ),
                                customTextFieldSection(
                                  Icons.person,
                                  "Cognome",
                                  "Inserisci il tuo cognome...",
                                  _surnnameFieldController,
                                  true,
                                  false,
                                  TextInputType.name,
                                  false,
                                ),
                                customTextFieldSection(
                                  Icons.mail,
                                  "Indirizzo Email",
                                  "Inserisci la tua mail...",
                                  _emailFieldcontroller,
                                  true,
                                  false,
                                  TextInputType.name,
                                  false,
                                ),
                                customTextFieldSection(
                                  Icons.phone,
                                  "Numero di telefono",
                                  "Inserisci il tuo numero di telefono...",
                                  _phoneFieldcontroller,
                                  true,
                                  false,
                                  TextInputType.name,
                                  false,
                                ),
                                customTextFieldSection(
                                  Icons.numbers,
                                  "Codice Organizzatore",
                                  "Se possiedi un codice inseriscilo...",
                                  _codeFieldcontroller,
                                  false,
                                  false,
                                  TextInputType.name,
                                  true,
                                ),
                                customTextFieldSection(
                                  Icons.password,
                                  "Password",
                                  "Inserisci la tua password...",
                                  _passwordFieldcontroller,
                                  true,
                                  true,
                                  TextInputType.name,
                                  false,
                                ),
                              ]),
                        )),
                    Center(
                        child: Column(children: [
                      Container(
                        height: 100,
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RawMaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32))),
                              elevation: 6,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text("Registrati",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600)),
                              ),
                              fillColor: Colors.green[300],
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Utente utente = Utente(
                                      -1,
                                      "",
                                      _nameFieldController.text,
                                      _surnnameFieldController.text,
                                      _emailFieldcontroller.text,
                                      _passwordFieldcontroller.text,
                                      true,
                                      _codeFieldcontroller.text.isEmpty
                                          ? false
                                          : true,
                                      [],
                                      [],
                                      0,
                                      Uri(path: ''));

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RegistrationLoadingView(
                                              utente: utente),
                                    ),
                                  );
                                }
                              },
                            ),
                            Text("Campi obbligatori*", style: sottotitoloOpaco)
                          ],
                        ),
                      ),
                    ])),
                  ],
                )))
      ],
    ));
  }

  Widget titleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Crea Account",
          style: titolo,
        ),
        Text(
          "Registrati per iniziare",
          style: sottotitoloOpaco,
        ),
      ],
    );
  }
}
