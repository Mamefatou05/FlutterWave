import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../models/ResponseModel.dart';

abstract class HttpClientInterface {
  Future<ResponseModel> post(String url, {Map<String, dynamic>? data, Map<String, String>? headers});
  Future<ResponseModel> get(String url, {Map<String, String>? headers});
  Future<ResponseModel> delete(String url, {Map<String, String>? headers});
  Future<ResponseModel> put(String url, {Map<String, dynamic>? data, Map<String, String>? headers});
}