import 'package:dio/src/response.dart';
import 'package:http/http.dart' as http;

import 'HttpClientInterface.dart';

class HttpClientHttp implements HttpClientInterface {
  @override
  Future<Response> delete(String url, {Map<String, dynamic>? headers}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Response> get(String url, {Map<String, dynamic>? headers}) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<Response> post(String url, {Map<String, dynamic>? data, Map<String, dynamic>? headers}) {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future<Response> put(String url, {Map<String, dynamic>? data, Map<String, dynamic>? headers}) {
    // TODO: implement put
    throw UnimplementedError();
  }

}
