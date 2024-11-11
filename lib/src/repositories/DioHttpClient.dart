import 'package:dio/dio.dart';

import 'HttpClientInterface.dart';

class DioHttpClient implements HttpClientInterface {
  final Dio _dio = Dio();

  DioHttpClient(Dio dio);

  @override
  Future<Response> post(String url, {Map<String, dynamic>? data, Map<String, dynamic>? headers}) async {
    try {
      final options = Options(headers: headers);
      return await _dio.post(url, data: data, options: options);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> get(String url, {Map<String, dynamic>? headers}) async {
    try {
      final options = Options(headers: headers);
      return await _dio.get(url, options: options);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> delete(String url, {Map<String, dynamic>? headers}) async {
    try {
      final options = Options(headers: headers);
      return await _dio.delete(url, options: options);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> put(String url, {Map<String, dynamic>? data, Map<String, dynamic>? headers}) async {
    try {
      final options = Options(headers: headers);
      return await _dio.put(url, data: data, options: options);
    } catch (e) {
      rethrow;
    }
  }
}