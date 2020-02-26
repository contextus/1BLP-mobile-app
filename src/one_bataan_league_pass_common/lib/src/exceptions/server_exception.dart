import 'package:one_bataan_league_pass_common/exceptions.dart';

class ServerException extends ApiException {
  ServerException(
    String message, [
    int statusCode,
    String method,
    String requestUri,
    String reasonPhrase,
  ]) : super(message, statusCode, method, requestUri, reasonPhrase);
}
