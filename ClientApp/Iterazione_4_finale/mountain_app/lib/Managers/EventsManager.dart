import 'dart:convert';
import 'dart:io';
import 'package:mountain_app/Models/Escursione.dart';
import 'package:mountain_app/Models/Utente.dart';
import 'package:mountain_app/Utilities/Constants.dart';
import 'package:http/http.dart' as http;

/// Manager responsabile delle chiamate http al server. Creato con un pattern Singleton
class EventsManger {
  //Istanza statica privata della classe
  static final EventsManger _instance = EventsManger._internal();
  late String _baseIpGateway;
  String _basicAuth =
      'Basic ${base64Encode(utf8.encode('${Utente.loggedUser.mail}:${Utente.loggedUser.password}'))}';

  factory EventsManger() {
    return _instance;
  }

  EventsManger._internal() {
    _baseIpGateway = getAddress();
  }

  Future<List<Escursione>> fetchEvents() async {
    try {
      final response = await http.get(Uri.parse('${_baseIpGateway}/events/'),
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

  void selectPartecipants(int idEvent) async {
    try {
      final _ = await http.get(
          Uri.parse('${_baseIpGateway}/events/${idEvent}/close'),
          headers: {HttpHeaders.authorizationHeader: _basicAuth});
    } catch (e) {
      print(e);
    }
  }

  Future<List<Escursione>> fetchBookedEvents() async {
    try {
      final response = await http.get(
          Uri.parse(
              '${_baseIpGateway}/profiles/${Utente.loggedUser.id}/reservations'),
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
    final response = await http.get(Uri.parse('$_baseIpGateway/events/$id'),
        headers: {HttpHeaders.authorizationHeader: _basicAuth});

    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      return Escursione.fromJson(decoded);
    } else {
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
      Uri.parse('$_baseIpGateway/events/reservation'),
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

  Future<bool> addEscursione(Escursione escursione) async {
    var body = json.encode(escursione.toJson(50));

    final response = await http.post(
      Uri.parse('$_baseIpGateway/events/new'),
      headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: _basicAuth,
      },
      body: body,
    );

    switch (response.statusCode) {
      case 200:
        return true;

      case 401:
        throw Exception('Login fallito');

      default:
        throw Exception('Fallimento: ' +
            response.body +
            " " +
            response.statusCode.toString());
    }
  }

  Future<bool> deleteEvent(int idEvent) async {
    final response = await http.delete(
        Uri.parse('$_baseIpGateway/events/$idEvent'),
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
