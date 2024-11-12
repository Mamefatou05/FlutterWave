import '../config.dart';
import '../core/storage/TokenStorageInterface.dart';
import '../models/ResponseModel.dart';
import 'HttpClientInterface.dart';

class ApiRepository {
  final HttpClientInterface _httpClient;
  final TokenStorageInterface _tokenStorage;

  ApiRepository({
    required HttpClientInterface httpClient,
    required TokenStorageInterface tokenStorage,
  })  : _httpClient = httpClient,
        _tokenStorage = tokenStorage;

  // Méthode pour récupérer le token d'accès
  Future<String?> _getAccessToken() async {
    return await _tokenStorage.getToken();
  }

  // Centralize token header addition
  Future<Map<String, String>> _getHeaders() async {
    final accessToken = await _getAccessToken();
    return accessToken != null ? {'Authorization': 'Bearer $accessToken'} : {};
  }

  Future<ResponseModel> post(String endpoint, Map<String, dynamic> data) async {
    final headers = await _getHeaders();
    return await _httpClient.post('$baseUrl$endpoint', data: data, headers: headers);
  }

  Future<ResponseModel> get(String endpoint) async {
    final headers = await _getHeaders();
    return await _httpClient.get('$baseUrl$endpoint', headers: headers);
  }

  Future<ResponseModel> delete(String endpoint) async {
    final headers = await _getHeaders();
    return await _httpClient.delete('$baseUrl$endpoint', headers: headers);
  }

  Future<ResponseModel> put(String endpoint, Map<String, dynamic> data) async {
    final headers = await _getHeaders();
    return await _httpClient.put('$baseUrl$endpoint', data: data, headers: headers);
  }
}
