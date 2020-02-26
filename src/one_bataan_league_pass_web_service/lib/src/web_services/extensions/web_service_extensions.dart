import 'package:one_bataan_league_pass_common/exceptions.dart';
import 'package:http/http.dart' show BaseResponse;

extension BaseResponseExtension on BaseResponse {
  bool isSuccessStatusCode() => this.statusCode >= 200 && this.statusCode < 300;

  bool isInternalServerErrorCode() => this.statusCode >= 500 && this.statusCode < 600;

  void ensureSuccessStatusCode() {
    if (this.isSuccessStatusCode()) {
      return;
    } else {
      if (this.isInternalServerErrorCode()) {
        throw ServerException(
          '${this.request.method} request failed, the server was unable to process this request.',
          this.statusCode,
          this.request.method,
          this.request.url.toString(),
          this.reasonPhrase,
        );
      } else {
        throw ApiException(
          '${this.request.method} request failed.',
          this.statusCode,
          this.request.method,
          this.request.url.toString(),
          this.reasonPhrase,
        );
      }
    }
  }
}
