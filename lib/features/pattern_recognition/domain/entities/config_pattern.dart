import 'package:equatable/equatable.dart';

import '../../../metadata_management/domain/entities/field_metadata.dart';

/// A pattern recognized in config files.
///
/// Represents a learned pattern that can be applied to similar configs.
class ConfigPattern extends Equatable {
  /// Creates a new config pattern.
  const ConfigPattern({
    required this.id,
    required this.fieldName,
    required this.metadata,
    required this.confidence,
    required this.occurrences,
    this.pluginName,
    this.configType,
    this.lastSeen,
  });

  /// Unique identifier for this pattern.
  final String id;

  /// Name of the field this pattern applies to.
  final String fieldName;

  /// Inferred metadata for this field.
  final FieldMetadata metadata;

  /// Confidence score (0.0 to 1.0).
  final double confidence;

  /// Number of times this pattern was observed.
  final int occurrences;

  /// Plugin name (if pattern is plugin-specific).
  final String? pluginName;

  /// Type of config (e.g., "skill", "loot_table", "npc").
  final String? configType;

  /// Last time this pattern was observed.
  final DateTime? lastSeen;

  /// Returns true if this pattern has high confidence.
  bool get isHighConfidence => confidence >= 0.7;

  /// Creates a copy with updated fields.
  ConfigPattern copyWith({
    String? id,
    String? fieldName,
    FieldMetadata? metadata,
    double? confidence,
    int? occurrences,
    String? pluginName,
    String? configType,
    DateTime? lastSeen,
  }) {
    return ConfigPattern(
      id: id ?? this.id,
      fieldName: fieldName ?? this.fieldName,
      metadata: metadata ?? this.metadata,
      confidence: confidence ?? this.confidence,
      occurrences: occurrences ?? this.occurrences,
      pluginName: pluginName ?? this.pluginName,
      configType: configType ?? this.configType,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        id,
        fieldName,
        metadata,
        confidence,
        occurrences,
        pluginName,
        configType,
        lastSeen,
      ];
}
