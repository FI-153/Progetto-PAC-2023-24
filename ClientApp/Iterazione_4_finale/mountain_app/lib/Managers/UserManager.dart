import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:mountain_app/Models/Utente.dart';
import 'package:mountain_app/Utilities/Constants.dart';

class UserManager {
  late String _baseIpGateway;

  static final UserManager _instance = UserManager._internal();
  UserManager._internal() {
    _baseIpGateway = getAddress();
  }

  factory UserManager() {
    return _instance;
  }

  Future<Utente> login(String username, String password) async {
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    final response = await http.get(Uri.parse('$_baseIpGateway/login'),
        headers: {HttpHeaders.authorizationHeader: basicAuth});

    switch (response.statusCode) {
      case 202:
        var decoded = json.decode(response.body);
        return Utente.fromJson(decoded);

      case 401:
        throw Exception('Login fallito');

      default:
        throw Exception('Fallimento');
    }
  }

  Future<Utente> addUser(Utente utente) async {
    var body = json.encode(utente.toJson());

    final response = await http.post(
      Uri.parse('$_baseIpGateway/profiles'),
      headers: {
        "Content-Type": "application/json",
      },
      body: body,
    );

    switch (response.statusCode) {
      case 201:
        var decoded = json.decode(response.body);
        return Utente.fromJson(decoded);

      case 401:
        throw Exception('Login fallito');

      default:
        throw Exception('Fallimento, forse la mail è ripetuta?');
    }
  }
}
