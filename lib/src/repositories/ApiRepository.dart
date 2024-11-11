import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import '../core/storage/TokenStorageInterface.dart';
import 'HttpClientInterface.dart';

class ApiRepository {
  final HttpClientInterface _httpClient;
  final bool useDio;
  final TokenStorageInterface _tokenStorage;

  ApiRepository({
    required HttpClientInterface httpClient,
    required TokenStorageInterface tokenStorage,
    required this.useDio,
  })  : _httpClient = httpClient,
        _tokenStorage = tokenStorage;

  // Méthode pour récupérer le token d'accès
  Future<String?> _getAccessToken() async {
    return await _tokenStorage.getToken();
  }

  // Méthode pour récupérer le token de rafraîchissement
  Future<String?> _getRefreshToken() async {
    return await _tokenStorage.getRefreshToken();
  }

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final accessToken = await _getAccessToken();
      final headers = accessToken != null
          ? {'Authorization': 'Bearer $accessToken'} as Map<String, dynamic> // Cast explicite ici
          : <String, dynamic>{};

      final response = await _httpClient.post(
        '$baseUrl$endpoint',
        data: data,
        headers: headers,
      );
      return _formatResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> get(String endpoint) async {
    try {
      final accessToken = await _getAccessToken();
      final headers = accessToken != null
          ? {'Authorization': 'Bearer $accessToken'} as Map<String, dynamic> // Cast explicite ici
          : <String, dynamic>{};

      final response = await _httpClient.get(
        '$baseUrl$endpoint',
        headers: headers,
      );
      return _formatResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> delete(String endpoint) async {
    try {
      final accessToken = await _getAccessToken();
      final headers = accessToken != null
          ? {'Authorization': 'Bearer $accessToken'} as Map<String, dynamic> // Cast explicite ici
          : <String, dynamic>{};

      final response = await _httpClient.delete(
        '$baseUrl$endpoint',
        headers: headers,
      );
      return _formatResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    try {
      final accessToken = await _getAccessToken();
      final headers = accessToken != null
          ? {'Authorization': 'Bearer $accessToken'} as Map<String, dynamic> // Cast explicite ici
          : <String, dynamic>{};

      final response = await _httpClient.put(
        '$baseUrl$endpoint',
        data: data,
        headers: headers,
      );
      return _formatResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  dynamic _formatResponse(Response response) {
    print("Réponse reçue : $response");
    print("Status Code: ${response.statusCode}");
    print("Data: ${response.data.containsKey('data') ? response.data['data'] : 'Aucune donnée'}");
    print("Message: ${response.data.containsKey('message') ? response.data['message'] : 'Aucun message'}");
    print("Status: ${response.data.containsKey('status') ? response.data['status'] : 'INCONNU'}");

    return {
      'statusCode': response.statusCode,
      'data': response.data.containsKey('data') ? response.data['data'] : {},
      'message': response.data.containsKey('message') ? response.data['message'] : 'Aucun message',
      'status': response.data.containsKey('status') ? response.data['status'] : 'INCONNU',
    };
  }

  dynamic _handleError(dynamic e) {
    if (e is DioException) {
      return {
        'statusCode': e.response?.statusCode ?? 500,
        'message': e.response?.data?.toString() ?? 'Erreur de connexion réseau',
        'status': 'ECHEC',
      };
    } else if (e is http.ClientException) {
      return {
        'statusCode': 500,
        'message': 'Erreur de connexion HTTP',
        'status': 'ECHEC',
      };
    }

    return {
      'statusCode': 500,
      'message': 'Erreur inconnue',
      'status': 'ECHEC'
    };
  }
}
