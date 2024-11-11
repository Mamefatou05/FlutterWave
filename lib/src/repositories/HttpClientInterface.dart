import 'package:dio/dio.dart';

abstract class HttpClientInterface {
  Future<Response> post(String url, {Map<String, dynamic>? data, Map<String, dynamic> headers});
  Future<Response> get(String url, {Map<String, dynamic> headers});
  Future<Response> delete(String url, {Map<String, dynamic> headers});
  Future<Response> put(String url, {Map<String, dynamic>? data, Map<String, dynamic> headers});
}