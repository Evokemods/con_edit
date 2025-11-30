import '../../features/config_editor/domain/entities/config_node.dart';
import '../../features/config_editor/domain/entities/config_value_type.dart';
import '../../features/metadata_management/domain/entities/field_metadata.dart';
import '../../features/metadata_management/domain/entities/metadata_constraint.dart';

/// Validator for config values against metadata constraints.
class ConfigValidator {
  ConfigValidator._();

  /// Validates a node value against metadata constraints.
  static String? validate(ConfigNode node, FieldMetadata? metadata) {
    if (metadata == null) {
      return null;
    }

    // Check required constraint
    for (final MetadataConstraint constraint in metadata.constraints) {
      if (constraint.type == ConstraintType.required) {
        if (node.value == null || node.value == '') {
          return constraint.customMessage ?? 'This field is required';
        }
      }
    }

    // Validate based on value type
    if (node.valueType.isNumeric && node.value is num) {
      return _validateNumeric(node.value as num, metadata);
    }

    if (node.valueType == ConfigValueType.string && node.value is String) {
      return _validateString(node.value as String, metadata);
    }

    return null;
  }

  /// Validates a numeric value.
  static String? _validateNumeric(num value, FieldMetadata metadata) {
    for (final MetadataConstraint constraint in metadata.constraints) {
      switch (constraint.type) {
        case ConstraintType.minValue:
          if (constraint.minValue != null && value < constraint.minValue!) {
            return constraint.customMessage ??
                'Value must be at least ${constraint.minValue}';
          }
          break;

        case ConstraintType.maxValue:
          if (constraint.maxValue != null && value > constraint.maxValue!) {
            return constraint.customMessage ??
                'Value must be at most ${constraint.maxValue}';
          }
          break;

        case ConstraintType.range:
          if (constraint.minValue != null && value < constraint.minValue!) {
            return constraint.customMessage ??
                'Value must be at least ${constraint.minValue}';
          }
          if (constraint.maxValue != null && value > constraint.maxValue!) {
            return constraint.customMessage ??
                'Value must be at most ${constraint.maxValue}';
          }
          break;

        default:
          break;
      }
    }

    return null;
  }

  /// Validates a string value.
  static String? _validateString(String value, FieldMetadata metadata) {
    for (final MetadataConstraint constraint in metadata.constraints) {
      switch (constraint.type) {
        case ConstraintType.minLength:
          if (constraint.minLength != null &&
              value.length < constraint.minLength!) {
            return constraint.customMessage ??
                'Length must be at least ${constraint.minLength} characters';
          }
          break;

        case ConstraintType.maxLength:
          if (constraint.maxLength != null &&
              value.length > constraint.maxLength!) {
            return constraint.customMessage ??
                'Length must be at most ${constraint.maxLength} characters';
          }
          break;

        case ConstraintType.lengthRange:
          if (constraint.minLength != null &&
              value.length < constraint.minLength!) {
            return constraint.customMessage ??
                'Length must be at least ${constraint.minLength} characters';
          }
          if (constraint.maxLength != null &&
              value.length > constraint.maxLength!) {
            return constraint.customMessage ??
                'Length must be at most ${constraint.maxLength} characters';
          }
          break;

        case ConstraintType.pattern:
          if (constraint.pattern != null) {
            final RegExp regex = RegExp(constraint.pattern!);
            if (!regex.hasMatch(value)) {
              return constraint.customMessage ??
                  'Value does not match required pattern';
            }
          }
          break;

        default:
          break;
      }
    }

    // Check allowed values
    if (metadata.allowedValues != null) {
      if (!metadata.allowedValues!.contains(value)) {
        return 'Value must be one of: ${metadata.allowedValues!.join(", ")}';
      }
    }

    return null;
  }
}

