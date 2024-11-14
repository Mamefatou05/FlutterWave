import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/ResponseModel.dart';
import 'HttpClientInterface.dart';

class HttpHttpClient implements HttpClientInterface {
  // Standardize response formatting for http package
  ResponseModel _formatResponse(http.Response response) {
    final decodedResponse = jsonDecode(response.body);

    // Assurez-vous que chaque champ est correctement extrait.
    // Si `data` contient un texte d'erreur, le déplacer dans `message`.
    final dataContent = (decodedResponse.containsKey('data') && decodedResponse['data'] is Map<String, dynamic>)
        ? decodedResponse['data']
        : {}; // Si `data` n'est pas une Map, on le laisse vide

    final messageContent = decodedResponse.containsKey('message')
        ? decodedResponse['message']
        : (decodedResponse.containsKey('data') && decodedResponse['data'] is String
        ? decodedResponse['data']
        : 'Aucun message'); // Utiliser `data` comme message si `data` est un texte

    final statusContent = decodedResponse.containsKey('status') ? decodedResponse['status'] : 'INCONNU';

    return ResponseModel(
      statusCode: response.statusCode,
      data: dataContent,
      message: messageContent,
      status: statusContent,
    );
  }

  // Handle errors consistently for http package
  ResponseModel _handleError(dynamic e) {
    if (e is http.ClientException) {
      return ResponseModel(
        statusCode: 500,
        data: {},
        message: 'Erreur de connexion HTTP',
        status: 'ECHEC',
      );
    }
    return ResponseModel(
      statusCode: 500,
      data: {},
      message: 'Erreur inconnue',
      status: 'ECHEC',
    );
  }

  @override
  Future<ResponseModel> post(String url, {Map<String, dynamic>? data, Map<String, String>? headers}) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );
      return _formatResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<ResponseModel> get(String url, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      return _formatResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<ResponseModel> delete(String url, {Map<String, String>? headers}) async {
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: headers,
      );
      return _formatResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<ResponseModel> put(String url, {Map<String, dynamic>? data, Map<String, String>? headers}) async {
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );
      return _formatResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }
}
