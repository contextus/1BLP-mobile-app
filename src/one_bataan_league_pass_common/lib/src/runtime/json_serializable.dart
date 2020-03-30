/// Marks an object that can be serialized to a JSON map.
abstract class JsonSerializable {
  /// Serializes this object to a JSON map.
  Map<String, Object> toJson();
}
