import '../../../config_editor/domain/entities/config_node.dart';
import '../../domain/entities/field_metadata.dart';
import '../../domain/entities/metadata_constraint.dart';

/// Service for validating config nodes against metadata constraints.
class ValidationService {
  /// Validates a node against its metadata constraints.
  ///
  /// Returns a list of error messages. Empty list means validation passed.
  static List<String> validateNode(
    ConfigNode node,
    FieldMetadata? metadata,
  ) {
    final List<String> errors = <String>[];

    if (metadata == null || metadata.constraints.isEmpty) {
      return errors;
    }

    final dynamic value = node.value;

    for (final MetadataConstraint constraint in metadata.constraints) {
      final String? error = _validateConstraint(value, constraint);
      if (error != null) {
        errors.add(error);
      }
    }

    return errors;
  }

  /// Validates a single constraint.
  static String? _validateConstraint(
    dynamic value,
    MetadataConstraint constraint,
  ) {
    switch (constraint.type) {
      case ConstraintType.required:
        if (value == null || (value is String && value.isEmpty)) {
          return constraint.customMessage ?? 'This field is required';
        }
        break;

      case ConstraintType.minValue:
        if (value is num && constraint.minValue != null) {
          if (value < constraint.minValue!) {
            return constraint.customMessage ??
                'Value must be at least ${constraint.minValue}';
          }
        }
        break;

      case ConstraintType.maxValue:
        if (value is num && constraint.maxValue != null) {
          if (value > constraint.maxValue!) {
            return constraint.customMessage ??
                'Value must be at most ${constraint.maxValue}';
          }
        }
        break;

      case ConstraintType.range:
        if (value is num &&
            constraint.minValue != null &&
            constraint.maxValue != null) {
          if (value < constraint.minValue! || value > constraint.maxValue!) {
            return constraint.customMessage ??
                'Value must be between ${constraint.minValue} and ${constraint.maxValue}';
          }
        }
        break;

      case ConstraintType.minLength:
        if (constraint.minLength != null) {
          if (value is String && value.length < constraint.minLength!) {
            return constraint.customMessage ??
                'Must be at least ${constraint.minLength} characters';
          }
          if (value is List && value.length < constraint.minLength!) {
            return constraint.customMessage ??
                'Must have at least ${constraint.minLength} items';
          }
        }
        break;

      case ConstraintType.maxLength:
        if (constraint.maxLength != null) {
          if (value is String && value.length > constraint.maxLength!) {
            return constraint.customMessage ??
                'Must be at most ${constraint.maxLength} characters';
          }
          if (value is List && value.length > constraint.maxLength!) {
            return constraint.customMessage ??
                'Must have at most ${constraint.maxLength} items';
          }
        }
        break;

      case ConstraintType.lengthRange:
        if (constraint.minLength != null && constraint.maxLength != null) {
          final int? length = value is String
              ? value.length
              : value is List
                  ? value.length
                  : null;

          if (length != null) {
            if (length < constraint.minLength! ||
                length > constraint.maxLength!) {
              return constraint.customMessage ??
                  'Length must be between ${constraint.minLength} and ${constraint.maxLength}';
            }
          }
        }
        break;

      case ConstraintType.pattern:
        if (value is String && constraint.pattern != null) {
          final RegExp regex = RegExp(constraint.pattern!);
          if (!regex.hasMatch(value)) {
            return constraint.customMessage ?? 'Invalid format';
          }
        }
        break;

      case ConstraintType.custom:
        // Custom constraints handled elsewhere
        break;
    }

    return null;
  }

  /// Checks if a value is valid without returning error messages.
  static bool isValid(ConfigNode node, FieldMetadata? metadata) {
    return validateNode(node, metadata).isEmpty;
  }
}
