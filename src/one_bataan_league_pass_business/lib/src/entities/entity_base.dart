import 'package:equatable/equatable.dart';

abstract class EntityBase {
  String get id => hashCode.toString();
}

abstract class EquatableEntityBase extends Equatable implements EntityBase {
  @override
  String get id => hashCode.toString();
}
