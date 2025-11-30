import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/documentation_source.dart';

/// Repository interface for documentation lookup and caching.
///
/// This abstract class defines the contract for fetching, parsing,
/// and caching documentation from external sources.
abstract class DocumentationRepository {
  /// Fetches documentation from a source.
  ///
  /// Returns [Right(String)] with documentation content on success,
  /// [Left(Failure)] on error.
  Future<Either<Failure, String>> fetchDocumentation(
    DocumentationSource source,
  );

  /// Gets cached documentation if available and not stale.
  ///
  /// Returns [Right(String)] if cached and fresh, [Left(NotFoundFailure)] if not cached.
  Future<Either<Failure, String>> getCachedDocumentation(String pluginName);

  /// Stores fetched documentation in cache.
  ///
  /// Returns [Right(Unit)] on success, [Left(Failure)] on error.
  Future<Either<Failure, Unit>> cacheDocumentation(
    String pluginName,
    String content,
  );

  /// Parses documentation to extract field descriptions and metadata.
  ///
  /// Returns [Right(Map<String, String>)] with field path to description mapping,
  /// [Left(Failure)] on error.
  Either<Failure, Map<String, String>> parseDocumentation(
    String content,
    DocumentationType type,
  );

  /// Adds a new documentation source for a plugin.
  ///
  /// Returns [Right(Unit)] on success, [Left(Failure)] on error.
  Future<Either<Failure, Unit>> addDocumentationSource(
    DocumentationSource source,
  );

  /// Gets all documentation sources for a plugin.
  ///
  /// Returns [Right(List<DocumentationSource>)] on success, [Left(Failure)] on error.
  Future<Either<Failure, List<DocumentationSource>>> getSourcesForPlugin(
    String pluginName,
  );

  /// Removes a documentation source.
  ///
  /// Returns [Right(Unit)] on success, [Left(Failure)] on error.
  Future<Either<Failure, Unit>> removeDocumentationSource(String sourceUrl);

  /// Refreshes all stale documentation caches.
  ///
  /// Returns [Right(int)] with number of sources refreshed,
  /// [Left(Failure)] on error.
  Future<Either<Failure, int>> refreshStaleDocumentation();

  /// Clears cached documentation for a plugin.
  ///
  /// Returns [Right(Unit)] on success, [Left(Failure)] on error.
  Future<Either<Failure, Unit>> clearCache(String pluginName);

  /// Searches documentation content for a query.
  ///
  /// Returns [Right(List<String>)] with matching sections,
  /// [Left(Failure)] on error.
  Future<Either<Failure, List<String>>> searchDocumentation(
    String pluginName,
    String query,
  );
}
