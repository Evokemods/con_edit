import 'package:drift/drift.dart';

/// Table for storing documentation sources.
///
/// Tracks configured documentation sources for plugins (URLs, repos, wikis).
@DataClassName('DocumentationSourceRow')
class DocumentationSourcesTable extends Table {
  @override
  String get tableName => 'documentation_sources';

  /// Unique identifier.
  IntColumn get id => integer().autoIncrement()();

  /// Plugin name this documentation is for.
  TextColumn get pluginName => text()();

  /// Type of source (e.g., "github_readme", "wiki", "api_docs", "custom").
  TextColumn get sourceType => text()();

  /// URL to the documentation.
  TextColumn get url => text()();

  /// Priority/order for checking sources (lower = higher priority).
  IntColumn get priority => integer().withDefault(const Constant<int>(0))();

  /// Whether this source is enabled.
  BoolColumn get enabled => boolean().withDefault(const Constant<bool>(true))();

  /// When this source was added.
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  /// When this source was last updated.
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}

/// Table for caching fetched documentation.
///
/// Stores downloaded documentation content to avoid repeated network requests.
@DataClassName('DocumentationCacheRow')
class DocumentationCacheTable extends Table {
  @override
  String get tableName => 'documentation_cache';

  /// Unique identifier.
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key to documentation_sources.
  IntColumn get sourceId => integer().references(
        DocumentationSourcesTable,
        #id,
        onDelete: KeyAction.cascade,
      )();

  /// URL that was fetched.
  TextColumn get url => text()();

  /// Cached content (markdown, HTML, or plain text).
  TextColumn get content => text()();

  /// Content type (e.g., "markdown", "html", "text").
  TextColumn get contentType => text().withDefault(const Constant<String>('text'))();

  /// When the content was fetched.
  DateTimeColumn get fetchedAt =>
      dateTime().withDefault(currentDateAndTime)();

  /// When the cache expires (for refresh logic).
  DateTimeColumn get expiresAt => dateTime()();

  /// ETag or version identifier for cache validation.
  TextColumn get etag => text().nullable()();
}

/// Table for storing parsed field documentation.
///
/// Extracted field information from documentation sources.
@DataClassName('ParsedFieldDocRow')
class ParsedFieldDocTable extends Table {
  @override
  String get tableName => 'parsed_field_docs';

  /// Unique identifier.
  IntColumn get id => integer().autoIncrement()();

  /// Foreign key to documentation_cache.
  IntColumn get cacheId => integer().references(
        DocumentationCacheTable,
        #id,
        onDelete: KeyAction.cascade,
      )();

  /// Plugin name.
  TextColumn get pluginName => text()();

  /// Field name or path.
  TextColumn get fieldName => text()();

  /// Extracted description.
  TextColumn get description => text().nullable()();

  /// Extracted valid values as JSON array.
  TextColumn get validValues => text().nullable()();

  /// Extracted examples as JSON.
  TextColumn get examples => text().nullable()();

  /// Extracted type information.
  TextColumn get typeInfo => text().nullable()();

  /// Confidence of the extraction (0.0 to 1.0).
  RealColumn get confidence => real().withDefault(const Constant<double>(0.5))();

  /// When this was parsed.
  DateTimeColumn get parsedAt =>
      dateTime().withDefault(currentDateAndTime)();
}
