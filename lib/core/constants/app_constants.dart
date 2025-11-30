/// Application-wide constants.
///
/// Centralized constants for configuration, storage keys, and other app-wide values.
class AppConstants {
  AppConstants._();

  // Storage keys
  /// Storage key for window width preference.
  static const String keyWindowWidth = 'window_width';

  /// Storage key for window height preference.
  static const String keyWindowHeight = 'window_height';

  /// Storage key for window X position preference.
  static const String keyWindowX = 'window_x';

  /// Storage key for window Y position preference.
  static const String keyWindowY = 'window_y';

  /// Storage key for theme mode preference.
  static const String keyThemeMode = 'theme_mode';

  /// Storage key for recent files list.
  static const String keyRecentFiles = 'recent_files';

  /// Storage key for auto-save enabled preference.
  static const String keyAutoSave = 'auto_save';

  /// Storage key for auto-save interval preference.
  static const String keyAutoSaveInterval = 'auto_save_interval';

  // Default values
  /// Default window width in pixels.
  static const double defaultWindowWidth = 1200.0;

  /// Default window height in pixels.
  static const double defaultWindowHeight = 800.0;

  /// Default auto-save interval in seconds.
  static const int defaultAutoSaveInterval = 30; // seconds

  // File extensions
  /// JSON file extension.
  static const String jsonExtension = '.json';

  /// Metadata file extension.
  static const String metadataExtension = '.metadata.json';

  // Metadata
  /// Current metadata schema version.
  static const String metadataVersion = '1.0.0';

  /// Default metadata file name.
  static const String metadataFileName = 'metadata.json';

  // Knowledge base
  /// Knowledge base database file name.
  static const String knowledgeBaseFileName = 'knowledge_base.db';

  // Documentation
  /// Default duration for caching documentation.
  static const Duration documentationCacheDuration = Duration(days: 7);

  /// Maximum size for documentation cache in megabytes.
  static const int maxDocumentationCacheSize = 100; // MB

  // Pattern recognition
  /// Minimum confidence score for learned patterns.
  static const double minConfidenceScore = 0.5;

  /// Minimum number of occurrences required for pattern recognition.
  static const int minOccurrencesForPattern = 3;

  // UI
  /// Maximum number of recent files to remember.
  static const int maxRecentFiles = 10;

  /// Maximum number of commands in undo/redo history.
  static const int maxUndoHistory = 100;
}
