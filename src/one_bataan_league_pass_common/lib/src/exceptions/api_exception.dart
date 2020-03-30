import 'package:one_bataan_league_pass_common/src/exceptions/exception_base.dart';

/// Exception thrown when a HTTP request returned an unsuccessful response.
///
/// This is thrown when the HTTP response's status code is not a `200` status code.
class ApiException extends ExceptionBase {
  ApiException(
    String message, [
    this.statusCode,
    this.method,
    this.requestUri,
    this.reasonPhrase,
  ]) : super(message);

  /// The HTTP status code of the response.
  final int statusCode;

  /// The HTTP method of the request.
  final String method;

  /// The request URI of the request.
  final String requestUri;

  /// The reason why the request failed.
  final String reasonPhrase;

  @override
  Map<String, Object> toJson() {
    return {
      'statusCode': statusCode,
      'method': method,
      'requestUri': requestUri,
      'reasonPhrase': reasonPhrase,
    };
  }
}
