import "Utente.dart";

enum Difficolta { hard, medium, easy }

class Escursione {
  final int id;
  final String nome;
  final Difficolta difficolta;
  final String luogo;
  final String data;
  final String descrizione;
  final List<Utente> partecipanti;
  final int idOrganizzatore;
  final String distanza;
  final String dislivello;
  final String tempo;
  final String altMax;
  final String altMin;
  final String strumentazione;
  final String luogoRitrovo;
  final String oraRitrovo;
  final Uri imgUrl;

  const Escursione({
    required this.id,
    required this.nome,
    required this.difficolta,
    required this.luogo,
    required this.data,
    required this.descrizione,
    required this.partecipanti,
    required this.idOrganizzatore,
    required this.distanza,
    required this.dislivello,
    required this.tempo,
    required this.altMax,
    required this.altMin,
    required this.strumentazione,
    required this.luogoRitrovo,
    required this.oraRitrovo,
    required this.imgUrl,
  });

  Escursione.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? json['idEvent'],
        nome = json['name'],
        luogo = json['place'],
        difficolta = Difficolta.values
            .byName(json["difficulty"].toString().toLowerCase()),
        data = json['date'],
        descrizione = json['description'],
        distanza = json['distance'],
        dislivello = json['heightLevel'],
        tempo = json['time'],
        altMin = json['minHeight'],
        altMax = "2000",
        strumentazione = json['tools'],
        luogoRitrovo = json['meetingPlace'],
        oraRitrovo = json['time'],
        imgUrl = Uri(path: ''),
        idOrganizzatore = json['idProfile'] ?? Utente.utenteMock2.id,
        partecipanti = Utente.listaPartecipantiMock;

  Map<String, dynamic> toJson(int maxPeople) => {
        'id': id,
        "name": nome,
        "place": luogo,
        "difficulty": difficolta.name.toUpperCase(),
        "date": "2024-02-26",
        "description": descrizione,
        "distance": distanza,
        "heightLevel": dislivello,
        "minHeight": altMin,
        "tools": strumentazione,
        "meetingPlace": luogoRitrovo,
        "maxPeople": maxPeople,
        "time": tempo,
        "idProfile": idOrganizzatore,
      };

  static Escursione escursioneMock = Escursione(
    id: 123,
    nome: "Tagliaferri",
    difficolta: Difficolta.easy,
    luogo: "Bergamo",
    data: "20 Settembre 2023",
    descrizione:
        "Dalla località Ronco di Schilpario (1075 m) si prende la mulattiera che sale in modo regolare lungo la valle del Vò. In prossimità delle cascate (deviazione sulla destra) il sentiero sale con svolte nel bosco e prosegue sempre lungo il lato sinistro (orografico destro). A quota 1650 (Venano di Mezzo) si attraversa il torrente (ponte di legno) e si sale con più decisione alla conca di Venano di Sopra (1850 m), che si attraversa per riprendere la salita sulla mulattiera, con pendenza costante e con ampi tornanti fino a quota 2202 m. Da qui si svolta in direzione nord e, con percorso più dolce, si arriva al rifugio Nani Tagliaferri (2328 m).",
    partecipanti: Utente.listaPartecipantiMock,
    idOrganizzatore: Utente.utenteMock1.id,
    distanza: "2.3km",
    dislivello: "956m",
    tempo: "7h55",
    altMax: "2425m",
    altMin: "1629m",
    strumentazione: "Tanta buona volontà",
    luogoRitrovo: "Fiumenero, BG",
    oraRitrovo: "7:30",
    imgUrl: Uri(path: ""),
  );

  static List<Escursione> escursioniMock =
      List.generate(10, (index) => escursioneMock);
}
