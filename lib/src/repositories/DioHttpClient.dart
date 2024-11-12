import 'package:dio/dio.dart';
import '../models/ResponseModel.dart';
import 'HttpClientInterface.dart';

class DioHttpClient implements HttpClientInterface {
  final Dio _dio = Dio();

  // Standardize response formatting
  ResponseModel _formatResponse(Response response) {
    return ResponseModel(
      statusCode: response.statusCode ?? 500,
      data: response.data['data'] ?? {},
      message: response.data['message'] ?? 'Aucun message',
      status: response.data['status'] ?? 'INCONNU',
    );
  }

  // Handle errors consistently
  ResponseModel _handleError(dynamic e) {
    if (e is DioException) {
      return ResponseModel(
        statusCode: e.response?.statusCode ?? 500,
        data: {},
        message: e.response?.data?.toString() ?? 'Erreur de connexion réseau',
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
      final response = await _dio.post(url, data: data, options: Options(headers: headers));
      return _formatResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<ResponseModel> get(String url, {Map<String, String>? headers}) async {
    try {
      final response = await _dio.get(url, options: Options(headers: headers));
      return _formatResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<ResponseModel> delete(String url, {Map<String, String>? headers}) async {
    try {
      final response = await _dio.delete(url, options: Options(headers: headers));
      return _formatResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<ResponseModel> put(String url, {Map<String, dynamic>? data, Map<String, String>? headers}) async {
    try {
      final response = await _dio.put(url, data: data, options: Options(headers: headers));
      return _formatResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }
}
