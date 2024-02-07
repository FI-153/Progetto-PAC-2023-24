import 'dart:convert';

class Utente {
  int id;
  String basicAuth;
  String nome;
  String cognome;
  String mail;
  String password;
  bool isLoggedIn;
  bool isOrganizer;
  List<int> iscrizioni;
  List<int> iscrizioniPassate;
  double esperienza;
  Uri urlImmagineProfilo;

  Utente(
    this.id,
    this.basicAuth,
    this.nome,
    this.cognome,
    this.mail,
    this.password,
    this.isLoggedIn,
    this.isOrganizer,
    this.iscrizioni,
    this.iscrizioniPassate,
    this.esperienza,
    this.urlImmagineProfilo,
  ) {}

  ///Informazioni dell'utente loggato nel sistema
  static Utente loggedUser = Utente.utenteMock1;

  Utente.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nome = json['firstName'],
        cognome = json['lastName'],
        mail = json['email'],
        password = json['password'],
        isOrganizer = (json['profileRole'].toString().toLowerCase() == "user")
            ? false
            : true,
        isLoggedIn = true,
        iscrizioni = List.from(json['bookedEvents']),
        iscrizioniPassate = List.from(json['pastBookedEvents']),
        esperienza = json['experience'] ?? 15,
        urlImmagineProfilo = Uri(path: ''),
        basicAuth =
            'Basic ${base64Encode(utf8.encode("$json['email']:$json['password']"))}';

  Map<String, dynamic> toJson() => {
        "firstName": nome,
        "lastName": cognome,
        "email": mail,
        "phone": "+390000000000",
        "password": password,
        "profileRole": (isOrganizer) ? "ORGANIZER" : "USER"
      };

//Dati mock usati per lo sviluppo
  static Utente utenteMock1 = Utente(
      2,
      "YWRtaW5AYWRtaW4uY29tOmFkbWlu",
      "Cristian(L)",
      "Tironi",
      "cri@gmail.com",
      "tiru",
      true,
      true,
      [39, 115],
      [39, 115],
      15,
      Uri(
          path:
              "https://images.pexels.com/photos/19551874/pexels-photo-19551874/free-photo-of-golden-retriever-in-christmas-headband.jpeg"));

  static Utente utenteMock2 = Utente(
      131,
      "YWRtaW5AYWRtaW4uY29tOmFkbWlu",
      "Federico(L)",
      "Imberti",
      "admin@admin.com",
      "admin",
      true,
      false,
      [37, 67],
      [37, 67],
      15,
      Uri(
          path:
              "https://as2.ftcdn.net/v2/jpg/03/26/98/51/1000_F_326985142_1aaKcEjMQW6ULp6oI9MYuv8lN9f8sFmj.jpg"));

  static List<Utente> listaOrganizzatoriMock = List.filled(2, utenteMock1);
  static List<Utente> listaPartecipantiMock = List.filled(10, utenteMock2);
}
