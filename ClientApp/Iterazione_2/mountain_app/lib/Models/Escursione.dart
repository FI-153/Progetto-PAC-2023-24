import "Utente.dart";

enum Difficolta { facile, medio, difficile }

class Escursione {
  final String id;
  final String nome;
  final Difficolta difficolta;
  final String luogo;
  final String data;
  final String descrizione;
  final List<Utente> partecipanti;
  final List<Utente> organizzatori;
  final String distanza;
  final String dislivello;
  final String tempo;
  final String altMax;
  final String altMin;
  final String strumentazione;
  final String luogoRitrovo;
  final String oraRitrovo;
  final Uri imgUrl;

  Escursione({
    required this.id,
    required this.nome,
    required this.difficolta,
    required this.luogo,
    required this.data,
    required this.descrizione,
    required this.partecipanti,
    required this.organizzatori,
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

  static Escursione escursioneMock = Escursione(
    id: "123",
    nome: "Tagliaferri",
    difficolta: Difficolta.facile,
    luogo: "Bergamo",
    data: "20 Settembre 2023",
    descrizione:
        "Dalla località Ronco di Schilpario (1075 m) si prende la mulattiera che sale in modo regolare lungo la valle del Vò. In prossimità delle cascate (deviazione sulla destra) il sentiero sale con svolte nel bosco e prosegue sempre lungo il lato sinistro (orografico destro). A quota 1650 (Venano di Mezzo) si attraversa il torrente (ponte di legno) e si sale con più decisione alla conca di Venano di Sopra (1850 m), che si attraversa per riprendere la salita sulla mulattiera, con pendenza costante e con ampi tornanti fino a quota 2202 m. Da qui si svolta in direzione nord e, con percorso più dolce, si arriva al rifugio Nani Tagliaferri (2328 m).",
    partecipanti: Utente.listaPartecipantiMock,
    organizzatori: Utente.listaOrganizzatoriMock,
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
