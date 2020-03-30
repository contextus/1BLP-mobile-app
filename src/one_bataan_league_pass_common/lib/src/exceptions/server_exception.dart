import 'package:one_bataan_league_pass_common/exceptions.dart';

/// Exception thrown when a HTTP request returned an unsuccessful response
/// because the server cannot process it.
///
/// This is thrown when the HTTP response's status code is a `500` status code.
class ServerException extends ApiException {
  ServerException(
    String message, [
    int statusCode,
    String method,
    String requestUri,
    String reasonPhrase,
  ]) : super(message, statusCode, method, requestUri, reasonPhrase);
}
