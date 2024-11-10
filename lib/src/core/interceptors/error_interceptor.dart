// lib/interceptors/error_interceptor.dart
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ErrorInterceptor {
  dynamic handleError(dynamic e) {
    if (e is DioException) {
      return DioException(
        requestOptions: e.requestOptions,
        response: e.response,
        error: e.response?.data?['message'] ?? 'Une erreur est survenue',
      );
    } else if (e is http.ClientException) {
      return {'statusCode': 500, 'message': 'Erreur de connexion HTTP'};
    }
    return {'statusCode': 500, 'message': 'Erreur inconnue'};
  }
}
