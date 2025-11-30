import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../features/documentation_lookup/data/datasources/documentation_tables.dart';
import '../../features/metadata_management/data/datasources/metadata_tables.dart';
import '../../features/pattern_recognition/data/datasources/pattern_tables.dart';

part 'app_database.g.dart';

/// Main application database.
///
/// Manages all database tables for metadata, patterns, and documentation.
/// Uses Drift for type-safe database operations.
@DriftDatabase(
  tables: <Type>[
    // Metadata tables
    FieldMetadataTable,
    MetadataConstraintsTable,
    // Pattern recognition tables
    ConfigPatternsTable,
    PatternFeedbackTable,
    FieldStatisticsTable,
    // Documentation tables
    DocumentationSourcesTable,
    DocumentationCacheTable,
    ParsedFieldDocTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  /// Creates a new AppDatabase instance.
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Add migration logic here when schema changes
      },
    );
  }
}

/// Opens a connection to the database.
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final Directory dbFolder = await getApplicationDocumentsDirectory();
    final File file = File(path.join(dbFolder.path, 'con_edit.db'));
    return NativeDatabase(file);
  });
}
