import '../runtime/json_serializable.dart';

abstract class ExceptionBase implements Exception, JsonSerializable {
  ExceptionBase([this.message]);

  final String message;
}
