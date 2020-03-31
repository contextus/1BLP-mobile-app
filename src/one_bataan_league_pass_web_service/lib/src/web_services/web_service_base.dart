import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:one_bataan_league_pass_common/common.dart';
import 'package:one_bataan_league_pass_web_service/src/web_services/http_handler.dart';
import 'package:one_bataan_league_pass_web_service/src/web_services/http_method.dart';

import 'package:http/http.dart';

class WebServiceBase {
  WebServiceBase(this._httpHandler);

  final HttpHandler _httpHandler;

  @protected
  Future<T> get<T>(
    String endpoint, {
    String accessToken,
    T Function(Map<String, Object> json) decoder,
  }) async {
    final response = await _internalSend(endpoint, HttpMethod.get, accessToken);

    return _decodeJsonResponseBody(response.body, decoder);
  }

  @protected
  Future<T> post<T>(
    String endpoint, {
    String accessToken,
    JsonSerializable parameter,
    T Function(Map<String, Object> json) decoder,
  }) async {
    final response = await _internalSendJson(endpoint, HttpMethod.post, parameter, accessToken);

    return _decodeJsonResponseBody(response.body, decoder);
  }

  @protected
  Future<T> put<T>(
    String endpoint, {
    String accessToken,
    JsonSerializable parameter,
    T Function(Map<String, Object> json) decoder,
  }) async {
    final response = await _internalSendJson(endpoint, HttpMethod.put, parameter, accessToken);

    return _decodeJsonResponseBody(response.body, decoder);
  }

  @protected
  Future<T> delete<T>(
    String endpoint, {
    String accessToken,
    T Function(Map<String, Object> json) decoder,
  }) async {
    final response = await _internalSend(endpoint, HttpMethod.delete, accessToken);

    return _decodeJsonResponseBody(response.body, decoder);
  }

  Future<Response> _internalSend(String endpoint, HttpMethod method, [String accessToken]) {
    return _httpHandler.send(endpoint, method, _buildHeaders(accessToken));
  }

  Future<Response> _internalSendJson(
    String endpoint,
    HttpMethod method,
    JsonSerializable parameter, [
    String accessToken,
  ]) {
    return _httpHandler.send(endpoint, method, _buildHeaders(accessToken), jsonEncode(parameter));
  }

  static Map<String, String> _buildHeaders(String accessToken) {
    final header = const {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };

    if (accessToken?.isNotEmpty ?? false == true)
      header.putIfAbsent(HttpHeaders.authorizationHeader, () => 'Bearer $accessToken');

    return header;
  }

  static T _decodeJsonResponseBody<T>(String json, T Function(Map<String, Object> json) decoder) {
    if ((decoder != null) && (json?.isNotEmpty ?? false == true))
      return decoder(jsonDecode(json));
    else
      return null;
  }
}
