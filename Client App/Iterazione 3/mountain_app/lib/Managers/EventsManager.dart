import 'dart:convert';
import 'dart:io';
import 'package:mountain_app/Models/Escursione.dart';
import 'package:mountain_app/Models/Utente.dart';
import 'package:mountain_app/Utilities/ConstantValues.dart';
import 'package:http/http.dart' as http;

/// Manager responsabile delle chiamate http al server. Creato con un pattern Singleton
class EventsManger {
  //Istanza statica privata della classe
  static final EventsManger _instance = EventsManger._internal();

  factory EventsManger() {
    return _instance;
  }

  EventsManger._internal() {}
  String _basicAuth =
      'Basic ${base64Encode(utf8.encode('${Utente.loggedUser.mail}:${Utente.loggedUser.password}'))}';

  Future<List<Escursione>> fetchEvents(String username, String password) async {
    try {
      final response = await http.get(Uri.parse('${baseIpGateway}/events/'),
          headers: {HttpHeaders.authorizationHeader: _basicAuth});

      List<dynamic> decoded = json.decode(response.body);
      List<Escursione> downEscursioni =
          decoded.map((escursione) => Escursione.fromJson(escursione)).toList();

      return downEscursioni;
    } catch (e) {
      print(e);
    }

    return [];
  }

  Future<Escursione> fetchEvent(int id) async {
    final response = await http.get(Uri.parse('$baseIpGateway/events/$id'),
        headers: {HttpHeaders.authorizationHeader: _basicAuth});

    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      return Escursione.fromJson(decoded);
    } else {
      print(response.statusCode);
      throw Exception('Failed to load escursione');
    }
  }

  Future<bool> addBooking(int idEvent) async {
    var body = jsonEncode(<String, dynamic>{
      'idProfile': Utente.loggedUser.id,
      'idEvent': idEvent,
      'datetime': "2024-01-14T19:21:07.000+00:00",
      'confirmation': false
    });

    final response = await http.post(
      Uri.parse('$baseIpGateway/events/reservation'),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: _basicAuth,
      },
      body: body,
    );

    if (response.statusCode == 200) {
      return true;
    } else
      return false;
  }

  Future<Escursione> addEscursione(Escursione escursione) async {
    var body = json.encode(escursione.toJson(50));

    final response = await http.post(
      Uri.parse('$baseIpGateway/profiles'),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: _basicAuth,
      },
      body: body,
    );

    switch (response.statusCode) {
      case 201:
        var decoded = json.decode(response.body);
        return Escursione.fromJson(decoded);

      case 401:
        throw Exception('Login fallito');

      default:
        throw Exception('Fallimento, forse la mail è ripetuta?');
    }
  }

  Future<bool> deleteEvent(int idEvent) async {
    final response = await http.delete(
        Uri.parse('$baseIpGateway/events/$idEvent'),
        headers: {HttpHeaders.authorizationHeader: _basicAuth});

    if (response.statusCode == 200) {
      print(response.body.toString());
      return true;
    } else {
      print(response.body.toString());
      throw Exception('Failed to delete event');
    }
  }
}
