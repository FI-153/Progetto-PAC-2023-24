import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mountain_app/Models/Escursione.dart';
import 'package:mountain_app/Models/Utente.dart';
import 'package:mountain_app/Utilities/Misc.dart';
import 'package:mountain_app/Views/CreateEventView/CreateEventViewLoading.dart';
import 'package:mountain_app/Views/CreateEventView/CustomTextFields.dart';

class CreateEventView extends StatefulWidget {
  const CreateEventView({super.key});

  @override
  State<CreateEventView> createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> {
  late TextEditingController _nameFieldController;
  late TextEditingController _placeFieldController;
  late TextEditingController _DateFieldcontroller;
  late TextEditingController _DescriptionFieldcontroller;
  late TextEditingController _distanceFieldcontroller;
  late TextEditingController _heightVarianceFieldcontroller;
  late TextEditingController _timeFieldcontroller;
  late TextEditingController _maxHeightFieldcontroller;
  late TextEditingController _minHeightFieldcontroller;
  late TextEditingController _gearFieldcontroller;
  late TextEditingController _meetupPlaceFieldcontroller;
  late TextEditingController _meetupTimeFieldcontroller;

  @override
  void initState() {
    super.initState();
    _nameFieldController = TextEditingController();
    _placeFieldController = TextEditingController();
    _DateFieldcontroller = TextEditingController();
    _DescriptionFieldcontroller = TextEditingController();
    _distanceFieldcontroller = TextEditingController();
    _heightVarianceFieldcontroller = TextEditingController();
    _timeFieldcontroller = TextEditingController();
    _maxHeightFieldcontroller = TextEditingController();
    _minHeightFieldcontroller = TextEditingController();
    _gearFieldcontroller = TextEditingController();
    _meetupPlaceFieldcontroller = TextEditingController();
    _meetupTimeFieldcontroller = TextEditingController();
  }

  @override
  void dispose() {
    _nameFieldController.dispose();
    _placeFieldController.dispose();
    _DateFieldcontroller.dispose();
    _DescriptionFieldcontroller.dispose();
    _distanceFieldcontroller.dispose();
    _heightVarianceFieldcontroller.dispose();
    _timeFieldcontroller.dispose();
    _maxHeightFieldcontroller.dispose();
    _minHeightFieldcontroller.dispose();
    _gearFieldcontroller.dispose();
    _meetupPlaceFieldcontroller.dispose();
    _meetupTimeFieldcontroller.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: 1900,
                width: 350,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    titleSection(),
                    Form(
                        key: _formKey,
                        child: Container(
                          height: 1500,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                customTextFieldSection(
                                  Icons.terrain,
                                  "Nome",
                                  "Il nome dell'evento",
                                  _nameFieldController,
                                  true,
                                  false,
                                  TextInputType.name,
                                  false,
                                ),
                                customTextFieldSection(
                                  Icons.place,
                                  "Luogo",
                                  "Dove si svolgerà l'evento",
                                  _placeFieldController,
                                  true,
                                  false,
                                  TextInputType.name,
                                  false,
                                ),
                                customTextFieldDateSection(
                                  Icons.date_range,
                                  "Data dell'escursione",
                                  "La data dell'evento",
                                  _DateFieldcontroller,
                                  true,
                                  false,
                                  TextInputType.datetime,
                                  false,
                                  context,
                                ),
                                customTextFieldSection(
                                  Icons.text_fields,
                                  "Descrizione",
                                  "Una breve descrizione",
                                  _DescriptionFieldcontroller,
                                  true,
                                  false,
                                  TextInputType.name,
                                  false,
                                ),
                                difficultyPickerSection(),
                                customTextFieldSection(
                                  Icons.map,
                                  "Distanza",
                                  "Distanza in Km del percorso",
                                  _distanceFieldcontroller,
                                  false,
                                  false,
                                  TextInputType.number,
                                  false,
                                ),
                                customTextFieldSection(
                                  Icons.height,
                                  "Dislivello",
                                  "Dislivello in m del percorso",
                                  _heightVarianceFieldcontroller,
                                  true,
                                  false,
                                  TextInputType.number,
                                  false,
                                ),
                                customTextFieldSection(
                                  Icons.timer,
                                  "Tempo",
                                  "Tempo medio in ore del percorso...",
                                  _timeFieldcontroller,
                                  true,
                                  false,
                                  TextInputType.number,
                                  false,
                                ),
                                customTextFieldSection(
                                  Icons.maximize,
                                  "Altezza massima",
                                  "Altezza massima in m del percorso...",
                                  _maxHeightFieldcontroller,
                                  true,
                                  false,
                                  TextInputType.number,
                                  false,
                                ),
                                customTextFieldSection(
                                  Icons.minimize,
                                  "Altezza Minima",
                                  "Altezza minima in m del percorso...",
                                  _minHeightFieldcontroller,
                                  true,
                                  false,
                                  TextInputType.number,
                                  false,
                                ),
                                customTextFieldSection(
                                  Icons.handyman,
                                  "Strumentazione",
                                  "Strumentazione che consigli di avere...",
                                  _gearFieldcontroller,
                                  true,
                                  false,
                                  TextInputType.name,
                                  false,
                                ),
                                customTextFieldSection(
                                  Icons.place,
                                  "Luogo Ritrovo",
                                  "Il luogo dove incontrarsi prima di partire",
                                  _meetupPlaceFieldcontroller,
                                  true,
                                  false,
                                  TextInputType.name,
                                  false,
                                ),
                                customTextFieldSection(
                                  Icons.alarm,
                                  "Ora Ritrovo",
                                  "L'ora in cui incontrarsi prima di partire",
                                  _meetupTimeFieldcontroller,
                                  true,
                                  false,
                                  TextInputType.datetime,
                                  false,
                                ),
                              ]),
                        )),
                    addEventSection(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container difficultyPickerSection() {
    return Container(
      height: 110,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Text(
                "Difficoltà: ",
                style: sottotitoloGrassetto,
              ),
              Text(translateDifficulty(_currentSliderValue).name),
            ],
          ),
          Slider(
            value: _currentSliderValue,
            max: 30,
            min: 10,
            divisions: 2,
            label: _currentSliderValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Difficolta translateDifficulty(double difficolta) {
    if (difficolta <= 10)
      return Difficolta.easy;
    else if (difficolta > 10 && difficolta <= 20)
      return Difficolta.medium;
    else
      return Difficolta.hard;
  }

  Widget addEventSection(BuildContext context) {
    return Center(
        child: Column(children: [
      Container(
        height: 100,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RawMaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32))),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Aggiungi Evento",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
              ),
              fillColor: Colors.green[300],
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Escursione escursione = Escursione(
                    id: 0 + Random().nextInt(1000),
                    nome: _nameFieldController.text,
                    difficolta: translateDifficulty(_currentSliderValue),
                    luogo: _placeFieldController.text,
                    data: _DateFieldcontroller.text,
                    descrizione: _DescriptionFieldcontroller.text,
                    partecipanti: [],
                    idOrganizzatore: Utente.loggedUser.id,
                    distanza: _distanceFieldcontroller.text,
                    dislivello: _heightVarianceFieldcontroller.text,
                    tempo: _timeFieldcontroller.text,
                    altMax: _maxHeightFieldcontroller.text,
                    altMin: _minHeightFieldcontroller.text,
                    strumentazione: _gearFieldcontroller.text,
                    luogoRitrovo: _meetupPlaceFieldcontroller.text,
                    oraRitrovo: _meetupTimeFieldcontroller.text,
                    imgUrl: Uri(path: ''),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateEventViewLoading(
                        escursione: escursione,
                      ),
                    ),
                  );
                }
              },
            ),
            Text("Campi obbligatori*", style: sottotitoloOpaco)
          ],
        ),
      ),
    ]));
  }

  Widget titleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Crea Evento",
          style: titolo,
        ),
        Text(
          "Compila i campi per creare un nuovo evento",
          style: sottotitoloOpaco,
        ),
      ],
    );
  }
}
