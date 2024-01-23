import 'dart:convert';
import 'dart:io';
import 'package:mountain_app/Models/Escursione.dart';
import 'package:http/http.dart' as http;

/// Manager responsabile delle chiamate http al server. Creato con un pattern Singleton
class ManagerEscursioni {
  /// Lista della gare scaricate
  late List<Escursione> escursioni;

  ///Indica se la pagina si sta caricando
  late bool isLoading;

  //Istanza statica privata della classe
  static final ManagerEscursioni _instance = ManagerEscursioni._internal();

  late String _baseIp;

  factory ManagerEscursioni() {
    return _instance;
  }

  ManagerEscursioni._internal() {
    _baseIp = "http://165.227.152.216:8085";
    isLoading = false;
    escursioni = [];
    fetchEvents();
  }

  void fetchEvents() async {
    String username = "admin@admin.com";
    String password = "admin";
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    isLoading = true;
    try {
      final response = await http.get(Uri.parse('$_baseIp/events/'),
          headers: {HttpHeaders.authorizationHeader: basicAuth});

      List<dynamic> decoded = json.decode(response.body);
      List<Escursione> downEscursioni =
          decoded.map((escursione) => Escursione.fromJson(escursione)).toList();

      escursioni = downEscursioni;
    } catch (e) {
      print(e);
    }

    isLoading = false;
  }

  Future<Escursione> fetchEvent(int id) async {
    String username = "admin@admin.com";
    String password = "admin";
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    final response = await http.get(Uri.parse('$_baseIp/events/$id'),
        headers: {HttpHeaders.authorizationHeader: basicAuth});

    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      return Escursione.fromJson(decoded);
    } else {
      print(response.statusCode);
      throw Exception('Failed to load escursione');
    }
  }
}