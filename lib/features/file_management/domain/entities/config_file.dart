import 'package:equatable/equatable.dart';

import '../../../config_editor/domain/entities/config_node.dart';

/// Represents a config file being edited.
class ConfigFile extends Equatable {
  /// Creates a new config file.
  const ConfigFile({
    required this.id,
    required this.filePath,
    required this.rootNode,
    this.metadataPath,
    this.isDirty = false,
    this.lastSaved,
    this.lastModified,
  });

  /// Unique identifier for this file.
  final String id;

  /// Path to the JSON config file.
  final String filePath;

  /// Root node of the parsed config tree.
  final ConfigNode rootNode;

  /// Path to the metadata file (if exists).
  final String? metadataPath;

  /// Whether the file has unsaved changes.
  final bool isDirty;

  /// Timestamp of last save.
  final DateTime? lastSaved;

  /// Timestamp of last modification.
  final DateTime? lastModified;

  /// Returns the file name without path.
  String get fileName {
    final List<String> parts = filePath.split('/');
    return parts.last;
  }

  /// Returns the directory containing the file.
  String get directory {
    final List<String> parts = filePath.split('/');
    parts.removeLast();
    return parts.join('/');
  }

  /// Creates a copy with updated fields.
  ConfigFile copyWith({
    String? id,
    String? filePath,
    ConfigNode? rootNode,
    String? metadataPath,
    bool? isDirty,
    DateTime? lastSaved,
    DateTime? lastModified,
  }) {
    return ConfigFile(
      id: id ?? this.id,
      filePath: filePath ?? this.filePath,
      rootNode: rootNode ?? this.rootNode,
      metadataPath: metadataPath ?? this.metadataPath,
      isDirty: isDirty ?? this.isDirty,
      lastSaved: lastSaved ?? this.lastSaved,
      lastModified: lastModified ?? this.lastModified,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        id,
        filePath,
        rootNode,
        metadataPath,
        isDirty,
        lastSaved,
        lastModified,
      ];
}
