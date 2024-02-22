import 'dart:convert';
import 'dart:math';

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
  String imgPath;

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
    this.imgPath,
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
        iscrizioni = List.from(json['bookedEvents'] ?? []),
        iscrizioniPassate = List.from(json['pastBookedEvents'] ?? []),
        esperienza = json['experience'] ?? 15,
        imgPath = randomizedProfileImage(),
        basicAuth = 'Basic ${base64Encode(
          utf8.encode("${json['email']}:${json['password']}"),
        )}';

  Map<String, dynamic> toJson() => {
        "firstName": nome,
        "lastName": cognome,
        "email": mail,
        "phone": "+390000000000",
        "password": password,
        "profileRole": (isOrganizer) ? "ORGANIZER" : "USER"
      };

  static String randomizedProfileImage() {
    int num = Random().nextInt(4) + 1 % 4;
    return 'images/me${num.toString()}.png';
  }

//Dati mock usati per lo sviluppo
  static Utente utenteMock1 = Utente(
    2,
    "Basic YWRtaW5AYWRtaW4uY29tOmFkbWlu",
    "Cristian(L)",
    "Tironi",
    "admin@admin.com",
    "admin",
    true,
    true,
    [6],
    [6, 7, 8],
    15,
    randomizedProfileImage(),
  );

  static Utente utenteMock2 = Utente(
    131,
    "Basic YWRtaW5AYWRtaW4uY29tOmFkbWlu",
    "Federico(L)",
    "Imberti",
    "admin@admin.com",
    "admin",
    true,
    false,
    [37, 67],
    [37, 67],
    15,
    randomizedProfileImage(),
  );

  static List<Utente> listaOrganizzatoriMock = List.filled(2, utenteMock1);
  static List<Utente> listaPartecipantiMock = List.filled(10, utenteMock2);
}
