import 'package:one_bataan_league_pass_common/src/json_serializable.dart';

abstract class ExceptionBase implements Exception, JsonSerializable {
  ExceptionBase([this.message]);

  final String message;
}
