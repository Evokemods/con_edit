import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import 'documentation_tables.dart';

part 'documentation_dao.g.dart';

/// Data Access Object for documentation operations.
///
/// Provides CRUD operations for documentation sources, cache, and parsed docs.
@DriftAccessor(
  tables: <Type>[
    DocumentationSourcesTable,
    DocumentationCacheTable,
    ParsedFieldDocTable,
  ],
)
class DocumentationDao extends DatabaseAccessor<AppDatabase>
    with _$DocumentationDaoMixin {
  /// Creates a new DocumentationDao.
  DocumentationDao(super.db);

  // ==================== DocumentationSource Operations ====================

  /// Gets all documentation sources.
  Future<List<DocumentationSourceRow>> getAllSources() {
    return (select(documentationSourcesTable)
          ..orderBy(
            <OrderingTerm Function(DocumentationSourcesTable)>[
              (DocumentationSourcesTable t) => OrderingTerm.asc(t.priority),
            ],
          ))
        .get();
  }

  /// Gets documentation sources for a plugin.
  Future<List<DocumentationSourceRow>> getSourcesByPlugin(String pluginName) {
    return (select(documentationSourcesTable)
          ..where(
            (DocumentationSourcesTable tbl) =>
                tbl.pluginName.equals(pluginName),
          )
          ..orderBy(
            <OrderingTerm Function(DocumentationSourcesTable)>[
              (DocumentationSourcesTable t) => OrderingTerm.asc(t.priority),
            ],
          ))
        .get();
  }

  /// Gets enabled documentation sources for a plugin.
  Future<List<DocumentationSourceRow>> getEnabledSourcesByPlugin(
    String pluginName,
  ) {
    return (select(documentationSourcesTable)
          ..where(
            (DocumentationSourcesTable tbl) =>
                tbl.pluginName.equals(pluginName) & tbl.enabled.equals(true),
          )
          ..orderBy(
            <OrderingTerm Function(DocumentationSourcesTable)>[
              (DocumentationSourcesTable t) => OrderingTerm.asc(t.priority),
            ],
          ))
        .get();
  }

  /// Adds a documentation source.
  Future<int> addSource(DocumentationSourcesTableCompanion source) {
    return into(documentationSourcesTable).insert(source);
  }

  /// Updates a documentation source.
  Future<int> updateSource(
    int id,
    DocumentationSourcesTableCompanion source,
  ) {
    return (update(documentationSourcesTable)
          ..where((DocumentationSourcesTable tbl) => tbl.id.equals(id)))
        .write(source);
  }

  /// Toggles source enabled status.
  Future<void> toggleSourceEnabled(int id, bool enabled) async {
    await (update(documentationSourcesTable)
          ..where((DocumentationSourcesTable tbl) => tbl.id.equals(id)))
        .write(
      DocumentationSourcesTableCompanion(
        enabled: Value<bool>(enabled),
        updatedAt: Value<DateTime>(DateTime.now()),
      ),
    );
  }

  /// Deletes a documentation source.
  Future<int> deleteSource(int id) {
    return (delete(documentationSourcesTable)
          ..where((DocumentationSourcesTable tbl) => tbl.id.equals(id)))
        .go();
  }

  // ==================== DocumentationCache Operations ====================

  /// Gets cached documentation by URL.
  Future<DocumentationCacheRow?> getCachedByUrl(String url) {
    return (select(documentationCacheTable)
          ..where((DocumentationCacheTable tbl) => tbl.url.equals(url)))
        .getSingleOrNull();
  }

  /// Gets cached documentation for a source.
  Future<List<DocumentationCacheRow>> getCachedBySource(int sourceId) {
    return (select(documentationCacheTable)
          ..where(
            (DocumentationCacheTable tbl) => tbl.sourceId.equals(sourceId),
          ))
        .get();
  }

  /// Checks if cache is expired.
  Future<bool> isCacheExpired(String url) async {
    final DocumentationCacheRow? cache = await getCachedByUrl(url);
    if (cache == null) return true;
    return DateTime.now().isAfter(cache.expiresAt);
  }

  /// Adds or updates cached documentation.
  Future<int> upsertCache(DocumentationCacheTableCompanion cache) {
    return into(documentationCacheTable).insertOnConflictUpdate(cache);
  }

  /// Deletes expired cache entries.
  Future<int> deleteExpiredCache() {
    return (delete(documentationCacheTable)
          ..where(
            (DocumentationCacheTable tbl) => tbl.expiresAt.isSmallerThan(
              Constant<DateTime>(DateTime.now()),
            ),
          ))
        .go();
  }

  /// Deletes cache for a source.
  Future<int> deleteCacheBySource(int sourceId) {
    return (delete(documentationCacheTable)
          ..where(
            (DocumentationCacheTable tbl) => tbl.sourceId.equals(sourceId),
          ))
        .go();
  }

  // ==================== ParsedFieldDoc Operations ====================

  /// Gets parsed field documentation.
  Future<ParsedFieldDocRow?> getParsedFieldDoc({
    required String pluginName,
    required String fieldName,
  }) {
    return (select(parsedFieldDocTable)
          ..where(
            (ParsedFieldDocTable tbl) =>
                tbl.pluginName.equals(pluginName) &
                tbl.fieldName.equals(fieldName),
          ))
        .getSingleOrNull();
  }

  /// Gets all parsed docs for a plugin.
  Future<List<ParsedFieldDocRow>> getParsedDocsByPlugin(String pluginName) {
    return (select(parsedFieldDocTable)
          ..where(
            (ParsedFieldDocTable tbl) => tbl.pluginName.equals(pluginName),
          ))
        .get();
  }

  /// Adds parsed field documentation.
  Future<int> addParsedDoc(ParsedFieldDocTableCompanion doc) {
    return into(parsedFieldDocTable).insert(doc);
  }

  /// Updates parsed field documentation.
  Future<int> updateParsedDoc(int id, ParsedFieldDocTableCompanion doc) {
    return (update(parsedFieldDocTable)
          ..where((ParsedFieldDocTable tbl) => tbl.id.equals(id)))
        .write(doc);
  }

  /// Deletes parsed docs for a cache entry.
  Future<int> deleteParsedDocsByCache(int cacheId) {
    return (delete(parsedFieldDocTable)
          ..where((ParsedFieldDocTable tbl) => tbl.cacheId.equals(cacheId)))
        .go();
  }

  /// Gets high-confidence parsed docs.
  Future<List<ParsedFieldDocRow>> getHighConfidenceParsedDocs(
    String pluginName,
  ) {
    return (select(parsedFieldDocTable)
          ..where(
            (ParsedFieldDocTable tbl) =>
                tbl.pluginName.equals(pluginName) &
                tbl.confidence.isBiggerOrEqualValue(0.7),
          ))
        .get();
  }
}
