class Utente {
  String id;
  String nome;
  String cognome;
  bool isLoggedIn;
  bool isOrganizer;
  List<String> iscrizioni;
  List<String> iscrizioniPassate;
  double punteggio;
  Uri urlImmagineProfilo;

  Utente(
    this.id,
    this.nome,
    this.cognome,
    this.isLoggedIn,
    this.isOrganizer,
    this.iscrizioni,
    this.iscrizioniPassate,
    this.punteggio,
    this.urlImmagineProfilo,
  ) {}

//Dati mock usati per lo sviluppo
  static Utente utenteMock1 = Utente(
      "1",
      "Cristian",
      "Tironi",
      true,
      true,
      ["123"],
      ["abc123", "cde456", "fgv556"],
      4.2,
      Uri(
          path:
              "https://images.pexels.com/photos/19551874/pexels-photo-19551874/free-photo-of-golden-retriever-in-christmas-headband.jpeg"));

  static Utente utenteMock2 = Utente(
      "2",
      "Federico",
      "Imberti",
      true,
      false,
      ["1234"],
      ["abc123", "cde456", "fgv556"],
      0,
      Uri(
          path:
              "https://as2.ftcdn.net/v2/jpg/03/26/98/51/1000_F_326985142_1aaKcEjMQW6ULp6oI9MYuv8lN9f8sFmj.jpg"));

  static List<Utente> listaOrganizzatoriMock = List.filled(2, utenteMock1);
  static List<Utente> listaPartecipantiMock = List.filled(10, utenteMock2);
}
