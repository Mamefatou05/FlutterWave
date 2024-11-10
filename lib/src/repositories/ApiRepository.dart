import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../core/interceptors/auth_interceptor.dart';
import '../core/storage/TokenStorageInterface.dart';

class ApiRepository {
  final Dio? _dio;
  final http.Client? _httpClient;
  final bool useDio;
  final AuthInterceptor _authInterceptor;
  final TokenStorageInterface _tokenStorage;

  ApiRepository({
    Dio? dio,
    http.Client? httpClient,
    required TokenStorageInterface tokenStorage,
    required this.useDio,
  })  : _dio = dio,
        _httpClient = httpClient,
        _tokenStorage = tokenStorage,
        _authInterceptor = AuthInterceptor(getToken: () => tokenStorage.getToken());

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
    try {
      if (useDio) {
        final response = await _dio!.post('$baseUrl$endpoint', data: data);
        return _formatResponse(response);
      } else {
        final request = http.Request('POST', Uri.parse('$baseUrl$endpoint'))
          ..body = jsonEncode(data);
        final modifiedRequest = await _authInterceptor.addAuthHeadersHttp(request);
        final response = await _httpClient!.send(modifiedRequest);
        return _formatResponse(await http.Response.fromStream(response));
      }
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> get(String endpoint) async {
    try {
      if (useDio) {
        final response = await _dio!.get('$baseUrl$endpoint');
        return _formatResponse(response);
      } else {
        final request = http.Request('GET', Uri.parse('$baseUrl$endpoint'));
        final modifiedRequest = await _authInterceptor.addAuthHeadersHttp(request);
        final response = await _httpClient!.send(modifiedRequest);
        return _formatResponse(await http.Response.fromStream(response));
      }
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> delete(String endpoint) async {
    try {
      if (useDio) {
        final response = await _dio!.delete('$baseUrl$endpoint');
        return _formatResponse(response);
      } else {
        final request = http.Request('DELETE', Uri.parse('$baseUrl$endpoint'));
        final modifiedRequest = await _authInterceptor.addAuthHeadersHttp(request);
        final response = await _httpClient!.send(modifiedRequest);
        return _formatResponse(await http.Response.fromStream(response));
      }
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    try {
      if (useDio) {
        final response = await _dio!.put('$baseUrl$endpoint', data: data);
        return _formatResponse(response);
      } else {
        final request = http.Request('PUT', Uri.parse('$baseUrl$endpoint'))
          ..body = jsonEncode(data);
        final modifiedRequest = await _authInterceptor.addAuthHeadersHttp(request);
        final response = await _httpClient!.send(modifiedRequest);
        return _formatResponse(await http.Response.fromStream(response));
      }
    } catch (e) {
      return _handleError(e);
    }
  }

  dynamic _formatResponse(dynamic response) {
    print("Réponse reçue : $response");

    if (response is http.Response) {
      print("Réponse HTTP détectée");
      final responseBody = response.body.isNotEmpty ? response.body : '{}';
      final responseJson = jsonDecode(responseBody);

      print("Status Code: ${response.statusCode}");
      print("Data: ${responseJson.containsKey('data') ? responseJson['data'] : 'Aucune donnée'}");
      print("Message: ${responseJson.containsKey('message') ? responseJson['message'] : 'Aucun message'}");
      print("Status: ${responseJson.containsKey('status') ? responseJson['status'] : 'INCONNU'}");

      return {
        'statusCode': response.statusCode,
        'data': responseJson.containsKey('data') ? responseJson['data'] : {},
        'message': responseJson.containsKey('message') ? responseJson['message'] : 'Aucun message',
        'status': responseJson.containsKey('status') ? responseJson['status'] : 'INCONNU',
      };
    } else if (response is Response) {
      print("Réponse Dio détectée");

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

    return null;
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
