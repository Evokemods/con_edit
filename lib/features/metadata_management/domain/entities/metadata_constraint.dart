import 'package:equatable/equatable.dart';

/// Constraint for validating field values.
class MetadataConstraint extends Equatable {
  /// Creates a new metadata constraint.
  const MetadataConstraint({
    required this.type,
    this.minValue,
    this.maxValue,
    this.minLength,
    this.maxLength,
    this.pattern,
    this.customMessage,
  });

  /// Type of constraint.
  final ConstraintType type;

  /// Minimum numeric value.
  final num? minValue;

  /// Maximum numeric value.
  final num? maxValue;

  /// Minimum string/array length.
  final int? minLength;

  /// Maximum string/array length.
  final int? maxLength;

  /// Regex pattern for string validation.
  final String? pattern;

  /// Custom error message for this constraint.
  final String? customMessage;

  @override
  List<Object?> get props => <Object?>[
        type,
        minValue,
        maxValue,
        minLength,
        maxLength,
        pattern,
        customMessage,
      ];
}

/// Types of validation constraints.
enum ConstraintType {
  /// Minimum value constraint.
  minValue,

  /// Maximum value constraint.
  maxValue,

  /// Range constraint (min and max).
  range,

  /// Minimum length constraint.
  minLength,

  /// Maximum length constraint.
  maxLength,

  /// Length range constraint.
  lengthRange,

  /// Regex pattern constraint.
  pattern,

  /// Required field constraint.
  required,

  /// Custom constraint.
  custom,
}
