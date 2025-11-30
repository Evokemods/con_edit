import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/database/app_database.dart';
import 'core/theme/app_theme.dart';
import 'features/config_editor/data/repositories/config_repository_impl.dart';
import 'features/config_editor/domain/usecases/convert_to_json.dart';
import 'features/config_editor/domain/usecases/parse_json.dart';
import 'features/config_editor/presentation/pages/page_based_editor_page.dart';
import 'features/config_editor/presentation/providers/config_provider.dart';
import 'features/file_management/data/repositories/file_repository_impl.dart';
import 'features/file_management/domain/usecases/open_file.dart';
import 'features/file_management/domain/usecases/save_file.dart';
import 'features/file_management/presentation/providers/file_provider.dart';
import 'features/metadata_management/data/datasources/metadata_dao.dart';
import 'features/metadata_management/data/repositories/metadata_repository_impl.dart';
import 'features/metadata_management/domain/usecases/get_field_metadata.dart';
import 'features/metadata_management/presentation/providers/metadata_provider.dart';
import 'features/pattern_recognition/data/datasources/pattern_dao.dart';
import 'features/pattern_recognition/data/repositories/pattern_repository_impl.dart';
import 'features/pattern_recognition/presentation/providers/analyze_configs_provider.dart';
import 'features/settings/data/repositories/settings_repository_impl.dart';
import 'features/settings/presentation/providers/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  // Initialize Database
  final AppDatabase database = AppDatabase();

  // Create DAOs
  final MetadataDao metadataDao = MetadataDao(database);
  final PatternDao patternDao = PatternDao(database);

  // Set up repositories
  const ConfigRepositoryImpl configRepository = ConfigRepositoryImpl();
  const FileRepositoryImpl fileRepository = FileRepositoryImpl();
  final SettingsRepositoryImpl settingsRepository = SettingsRepositoryImpl(sharedPreferences);
  final PatternRepositoryImpl patternRepository = PatternRepositoryImpl(patternDao, metadataDao);
  final MetadataRepositoryImpl metadataRepository = MetadataRepositoryImpl(
    fileRepository,
    metadataDao,
    patternRepository: patternRepository,
  );

  // Set up use cases
  const ParseJson parseJson = ParseJson(configRepository);
  const ConvertToJson convertToJson = ConvertToJson(configRepository);
  const OpenFile openFile = OpenFile(fileRepository);
  const SaveFile saveFile = SaveFile(fileRepository);
  final GetFieldMetadata getFieldMetadata = GetFieldMetadata(metadataRepository);

  runApp(
    ProviderScope(
      overrides: <Override>[
        parseJsonProvider.overrideWithValue(parseJson),
        convertToJsonProvider.overrideWithValue(convertToJson),
        openFileProvider.overrideWithValue(openFile),
        saveFileProvider.overrideWithValue(saveFile),
        settingsRepositoryProvider.overrideWithValue(settingsRepository),
        patternRepositoryProvider.overrideWithValue(patternRepository),
        getFieldMetadataProvider.overrideWithValue(getFieldMetadata),
      ],
      child: const ConEditApp(),
    ),
  );
}

/// Main application widget.
class ConEditApp extends ConsumerWidget {
  /// Creates a new ConEditApp.
  const ConEditApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'ConEdit - Config Editor',
      theme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const PageBasedEditorPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
