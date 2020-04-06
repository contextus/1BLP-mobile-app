import 'dart:async';

import 'package:one_bataan_league_pass_common/exceptions.dart';
import 'package:one_bataan_league_pass_common/logging.dart';
import 'package:one_bataan_league_pass_common/common.dart';
import 'package:one_bataan_league_pass_web_service/src/web_services/extensions/web_service_extensions.dart';
import 'package:one_bataan_league_pass_web_service/src/web_services/http_method.dart';

import 'package:http/http.dart';

/// Handles HTTP requests.
abstract class HttpHandler {
  /// Sends a HTTP request.
  Future<Response> send(
    String endpoint,
    HttpMethod httpMethod, [
    Map<String, String> headers,
    dynamic body,
  ]);

  /// Builds the client to be used for sending HTTP requests.
  @protected
  @visibleForTesting
  Client buildClient();
}

class HttpHandlerImpl implements HttpHandler {
  static const _timeOutDuration = Duration(seconds: 30);

  @override
  Future<Response> send(
    String endpoint,
    HttpMethod httpMethod, [
    Map<String, String> headers,
    dynamic body,
  ]) async {
    final httpMethodTag = httpMethod.toString().split('.')[1].toUpperCase();
    final client = buildClient();
    final uri = Uri.parse('${AppConfiguration.serverAddress}/$endpoint');
    Future<Response> Function() request;
    Response response;

    try {
      debugInfo('Sending $httpMethodTag $uri');

      switch (httpMethod) {
        case HttpMethod.get:
          request = () => client.get(uri, headers: headers);
          break;

        case HttpMethod.post:
          request = () => client.post(uri, headers: headers, body: body);
          break;

        case HttpMethod.put:
          request = () => client.put(uri, headers: headers, body: body);
          break;

        case HttpMethod.delete:
          request = () => client.delete(uri, headers: headers);
          break;
      }

      response = await request().timeout(_timeOutDuration);

      response.ensureSuccessStatusCode();

      debugInfo('Success $httpMethodTag (${response.statusCode} ${response.reasonPhrase}) $uri');

      return response;
    } on ApiException catch (e) {
      debugError('Failed $httpMethodTag (${response.statusCode} ${response.reasonPhrase}) $uri', e);
      rethrow;
    } on TimeoutException {
      debugError('Request timed-out $httpMethodTag $uri');
      rethrow;
    } finally {
      client.close();
    }
  }

  @protected
  @visibleForTesting
  @override
  Client buildClient() => Client();
}
