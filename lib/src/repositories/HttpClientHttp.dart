import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/ResponseModel.dart';
import 'HttpClientInterface.dart';

class HttpHttpClient implements HttpClientInterface {
  // Standardize response formatting for http package
  ResponseModel _formatResponse(http.Response response) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    return ResponseModel(
      statusCode: response.statusCode,
      data: data.containsKey('data') ? data['data'] : {},
      message: data.containsKey('message') ? data['message'] : 'Aucun message',
      status: data.containsKey('status') ? data['status'] : 'INCONNU',
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
