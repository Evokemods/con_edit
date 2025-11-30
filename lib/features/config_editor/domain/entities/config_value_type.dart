/// Enum representing the different types of values in a config.
enum ConfigValueType {
  /// A null value
  nullValue,

  /// A boolean value (true/false)
  boolean,

  /// An integer number
  integer,

  /// A floating point number
  double,

  /// A string value
  string,

  /// An array/list of values
  array,

  /// An object/map of key-value pairs
  object,

  /// Unknown or unsupported type
  unknown;

  /// Returns true if this type is a primitive value (not array or object).
  bool get isPrimitive =>
      this == ConfigValueType.boolean ||
      this == ConfigValueType.integer ||
      this == ConfigValueType.double ||
      this == ConfigValueType.string ||
      this == ConfigValueType.nullValue;

  /// Returns true if this type is a collection (array or object).
  bool get isCollection =>
      this == ConfigValueType.array || this == ConfigValueType.object;

  /// Returns true if this type is numeric (integer or double).
  bool get isNumeric =>
      this == ConfigValueType.integer || this == ConfigValueType.double;
}
