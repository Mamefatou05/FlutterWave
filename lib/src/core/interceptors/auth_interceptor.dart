import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class AuthInterceptor {
  final Future<String?> Function() getToken;

  AuthInterceptor({required this.getToken});

  Future<void> addAuthHeadersDio(RequestOptions options) async {
    final token = await getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
  }

  Future<http.BaseRequest> addAuthHeadersHttp(http.BaseRequest request) async {
    final token = await getToken();
    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }
    return request;
  }
}