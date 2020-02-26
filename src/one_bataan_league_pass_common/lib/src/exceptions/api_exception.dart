import 'package:one_bataan_league_pass_common/src/exceptions/exception_base.dart';

class ApiException extends ExceptionBase {
  ApiException(
    String message, [
    this.statusCode,
    this.method,
    this.requestUri,
    this.reasonPhrase,
  ]) : super(message);

  final int statusCode;
  final String method;
  final String requestUri;
  final String reasonPhrase;

  @override
  Map<String, Object> toJson() {
    return {
      'statuseCode': statusCode,
      'method': method,
      'requestUri': requestUri,
      'reasonPhrase': reasonPhrase,
    };
  }
}
