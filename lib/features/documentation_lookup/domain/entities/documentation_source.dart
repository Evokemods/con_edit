import 'package:equatable/equatable.dart';

/// Represents a source of documentation for a plugin.
class DocumentationSource extends Equatable {
  /// Creates a new documentation source.
  const DocumentationSource({
    required this.pluginName,
    required this.sourceUrl,
    required this.sourceType,
    this.lastFetched,
    this.cacheDuration = const Duration(hours: 24),
    this.isActive = true,
    this.priority = 0,
  });

  /// Name of the plugin this documentation is for.
  final String pluginName;

  /// URL to the documentation source.
  final String sourceUrl;

  /// Type of documentation source.
  final DocumentationType sourceType;

  /// Last time documentation was fetched from this source.
  final DateTime? lastFetched;

  /// How long to cache the documentation.
  final Duration cacheDuration;

  /// Whether this source is currently active.
  final bool isActive;

  /// Priority for this source (higher = checked first).
  final int priority;

  /// Returns true if the cached documentation is stale.
  bool get isStale {
    if (lastFetched == null) {
      return true;
    }
    return DateTime.now().difference(lastFetched!) > cacheDuration;
  }

  /// Creates a copy with updated fields.
  DocumentationSource copyWith({
    String? pluginName,
    String? sourceUrl,
    DocumentationType? sourceType,
    DateTime? lastFetched,
    Duration? cacheDuration,
    bool? isActive,
    int? priority,
  }) {
    return DocumentationSource(
      pluginName: pluginName ?? this.pluginName,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      sourceType: sourceType ?? this.sourceType,
      lastFetched: lastFetched ?? this.lastFetched,
      cacheDuration: cacheDuration ?? this.cacheDuration,
      isActive: isActive ?? this.isActive,
      priority: priority ?? this.priority,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        pluginName,
        sourceUrl,
        sourceType,
        lastFetched,
        cacheDuration,
        isActive,
        priority,
      ];
}

/// Types of documentation sources.
enum DocumentationType {
  /// GitHub README file
  githubReadme,

  /// GitHub Wiki
  githubWiki,

  /// Generic wiki page
  wiki,

  /// API documentation
  apiDocs,

  /// Plain text file
  textFile,

  /// Markdown file
  markdown,

  /// HTML page
  html;
}
