import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import 'metadata_tables.dart';

part 'metadata_dao.g.dart';

/// Data Access Object for metadata operations.
///
/// Provides CRUD operations for field metadata and constraints.
@DriftAccessor(tables: <Type>[FieldMetadataTable, MetadataConstraintsTable])
class MetadataDao extends DatabaseAccessor<AppDatabase> with _$MetadataDaoMixin {
  /// Creates a new MetadataDao.
  MetadataDao(super.db);

  // ==================== FieldMetadata Operations ====================

  /// Gets all field metadata entries.
  Future<List<FieldMetadataRow>> getAllMetadata() {
    return select(fieldMetadataTable).get();
  }

  /// Gets metadata by field path.
  Future<FieldMetadataRow?> getMetadataByPath(String fieldPath) {
    return (select(fieldMetadataTable)
          ..where((FieldMetadataTable tbl) => tbl.fieldPath.equals(fieldPath)))
        .getSingleOrNull();
  }

  /// Gets metadata by field path with optional plugin and config type filters.
  Future<FieldMetadataRow?> getMetadataByPathFiltered({
    required String fieldPath,
    String? pluginName,
    String? configType,
  }) {
    final SimpleSelectStatement<$FieldMetadataTableTable, FieldMetadataRow>
        query = select(fieldMetadataTable)
          ..where((FieldMetadataTable tbl) => tbl.fieldPath.equals(fieldPath));

    if (pluginName != null) {
      query.where((FieldMetadataTable tbl) => tbl.pluginName.equals(pluginName));
    }
    if (configType != null) {
      query.where((FieldMetadataTable tbl) => tbl.configType.equals(configType));
    }

    return query.getSingleOrNull();
  }

  /// Gets all metadata for a specific plugin.
  Future<List<FieldMetadataRow>> getMetadataByPlugin(String pluginName) {
    return (select(fieldMetadataTable)
          ..where((FieldMetadataTable tbl) => tbl.pluginName.equals(pluginName)))
        .get();
  }

  /// Gets all high-confidence metadata (confidence >= 0.7).
  Future<List<FieldMetadataRow>> getHighConfidenceMetadata() {
    return (select(fieldMetadataTable)
          ..where((FieldMetadataTable tbl) => tbl.confidence.isBiggerOrEqualValue(0.7)))
        .get();
  }

  /// Gets all learned metadata (confidence < 1.0).
  Future<List<FieldMetadataRow>> getLearnedMetadata() {
    return (select(fieldMetadataTable)
          ..where((FieldMetadataTable tbl) => tbl.confidence.isSmallerThan(const Constant<double>(1.0))))
        .get();
  }

  /// Inserts or updates field metadata.
  Future<int> upsertMetadata(FieldMetadataTableCompanion entry) {
    return into(fieldMetadataTable).insertOnConflictUpdate(entry);
  }

  /// Updates metadata confidence score.
  Future<int> updateMetadataConfidence(int id, double confidence) {
    return (update(fieldMetadataTable)..where((FieldMetadataTable tbl) => tbl.id.equals(id)))
        .write(
      FieldMetadataTableCompanion(
        confidence: Value<double>(confidence),
        updatedAt: Value<DateTime>(DateTime.now()),
      ),
    );
  }

  /// Deletes metadata by ID.
  Future<int> deleteMetadata(int id) {
    return (delete(fieldMetadataTable)..where((FieldMetadataTable tbl) => tbl.id.equals(id)))
        .go();
  }

  /// Deletes all metadata for a plugin.
  Future<int> deleteMetadataByPlugin(String pluginName) {
    return (delete(fieldMetadataTable)
          ..where((FieldMetadataTable tbl) => tbl.pluginName.equals(pluginName)))
        .go();
  }

  // ==================== MetadataConstraint Operations ====================

  /// Gets all constraints for a field metadata entry.
  Future<List<MetadataConstraintRow>> getConstraints(int fieldMetadataId) {
    return (select(metadataConstraintsTable)
          ..where(
            (MetadataConstraintsTable tbl) =>
                tbl.fieldMetadataId.equals(fieldMetadataId),
          ))
        .get();
  }

  /// Adds a constraint to field metadata.
  Future<int> addConstraint(MetadataConstraintsTableCompanion constraint) {
    return into(metadataConstraintsTable).insert(constraint);
  }

  /// Deletes all constraints for a field metadata entry.
  Future<int> deleteConstraints(int fieldMetadataId) {
    return (delete(metadataConstraintsTable)
          ..where(
            (MetadataConstraintsTable tbl) =>
                tbl.fieldMetadataId.equals(fieldMetadataId),
          ))
        .go();
  }

  /// Gets metadata with all its constraints (join query).
  Future<List<FieldMetadataWithConstraints>> getMetadataWithConstraints(
    String fieldPath,
  ) async {
    final FieldMetadataRow? metadata = await getMetadataByPath(fieldPath);
    if (metadata == null) return <FieldMetadataWithConstraints>[];

    final List<MetadataConstraintRow> constraints =
        await getConstraints(metadata.id);

    return <FieldMetadataWithConstraints>[
      FieldMetadataWithConstraints(
        metadata: metadata,
        constraints: constraints,
      ),
    ];
  }
}

/// Combined result of metadata and its constraints.
class FieldMetadataWithConstraints {
  /// Creates a new combined result.
  const FieldMetadataWithConstraints({
    required this.metadata,
    required this.constraints,
  });

  /// The field metadata.
  final FieldMetadataRow metadata;

  /// Associated constraints.
  final List<MetadataConstraintRow> constraints;
}
