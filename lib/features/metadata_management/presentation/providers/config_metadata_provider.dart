import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../config_editor/domain/entities/config_node.dart';
import '../../../config_editor/presentation/providers/config_provider.dart';
import '../../domain/entities/field_metadata.dart';
import '../../domain/usecases/extract_config_metadata.dart';

/// Provider for ExtractConfigMetadata use case.
final Provider<ExtractConfigMetadata> extractConfigMetadataProvider =
    Provider<ExtractConfigMetadata>((Ref ref) {
  return ExtractConfigMetadata();
});

/// Provider that extracts metadata from a config node.
///
/// This provider automatically extracts metadata from field names and values
/// when a config is loaded, making the editor "brainier" by understanding
/// the structure and providing hints, descriptions, and validation.
final FutureProviderFamily<List<FieldMetadata>, ConfigNode>
    configMetadataProvider = FutureProvider.family<List<FieldMetadata>, ConfigNode>(
  (Ref ref, ConfigNode rootNode) async {
    final ExtractConfigMetadata extractor = ref.read(extractConfigMetadataProvider);
    
    // Extract plugin name from file path if available
    // For now, we'll extract from the root node structure
    String? pluginName;
    if (rootNode.children.isNotEmpty) {
      // Try to infer plugin name from common patterns
      final ConfigNode? firstChild = rootNode.children.firstOrNull;
      if (firstChild?.key != null) {
        final String key = firstChild!.key!;
        // Check if it matches known plugin patterns
        if (key.toLowerCase().contains('team')) {
          pluginName = 'BetterTeams';
        } else if (key.toLowerCase().contains('hud')) {
          pluginName = 'Hud';
        } else if (key.toLowerCase().contains('epic') || key.toLowerCase().contains('loot')) {
          pluginName = 'EpicLoot';
        } else if (key.toLowerCase().contains('skill')) {
          pluginName = 'Skills';
        }
      }
    }

    final Either<Failure, List<FieldMetadata>> result =
        await extractor.extractMetadata(rootNode, pluginName: pluginName);

    return result.fold(
      (Failure failure) => <FieldMetadata>[],
      (List<FieldMetadata> metadata) => metadata,
    );
  },
);

/// Provider that gets metadata for a specific field path.
///
/// This combines extracted metadata with stored metadata from the database.
final ProviderFamily<FieldMetadata?, String> fieldMetadataProvider =
    Provider.family<FieldMetadata?, String>(
  (Ref ref, String fieldPath) {
    // Get current file path from config editor state
    final String? configFilePath = ref.watch(
      configEditorProvider.select((ConfigEditorState state) => state.currentFilePath),
    );

    // Skip metadata lookup if no file is loaded
    if (configFilePath == null || configFilePath.isEmpty) {
      if (fieldPath.toLowerCase().contains('short')) {
        debugPrint('🔍 PROVIDER: No file loaded, skipping lookup for "$fieldPath"');
      }
      return null;
    }

    // Get metadata from cache
    final Map<String, List<FieldMetadata>> cache = ref.watch(
      configMetadataCacheProvider(configFilePath),
    );

    // Debug logging for shortname fields
    if (fieldPath.toLowerCase().contains('short')) {
      debugPrint('🔍 PROVIDER: Looking up "$fieldPath"');
      debugPrint('   - cache has ${cache.length} entries');
      debugPrint('   - cache keys: ${cache.keys.take(5).join(", ")}...');
      debugPrint('   - exact match: ${cache.containsKey(fieldPath)}');
    }

    // Look up metadata for this field path
    final List<FieldMetadata>? metadataList = cache[fieldPath];
    if (metadataList == null || metadataList.isEmpty) {
      if (fieldPath.toLowerCase().contains('short')) {
        debugPrint('   - ❌ NOT FOUND in cache');
      }
      return null;
    }

    if (fieldPath.toLowerCase().contains('short')) {
      debugPrint('   - ✅ FOUND ${metadataList.length} metadata entries');
    }

    // Return the metadata with highest confidence
    metadataList.sort((FieldMetadata a, FieldMetadata b) =>
        b.confidence.compareTo(a.confidence));
    return metadataList.first;
  },
);

/// Provider that caches extracted metadata by config file path.
final StateNotifierProviderFamily<ConfigMetadataCacheNotifier, Map<String, List<FieldMetadata>>, String>
    configMetadataCacheProvider = StateNotifierProvider.family<
        ConfigMetadataCacheNotifier,
        Map<String, List<FieldMetadata>>,
        String>(
  (Ref ref, String configFilePath) {
    return ConfigMetadataCacheNotifier(ref, configFilePath);
  },
);

/// Notifier that caches and manages metadata for a config file.
class ConfigMetadataCacheNotifier
    extends StateNotifier<Map<String, List<FieldMetadata>>> {
  /// Creates a new ConfigMetadataCacheNotifier.
  ConfigMetadataCacheNotifier(this.ref, this.configFilePath)
      : super(<String, List<FieldMetadata>>{});

  /// Reference for accessing providers.
  final Ref ref;

  /// Path to the config file.
  final String configFilePath;

  /// Extracts and caches metadata for a config node.
  Future<void> extractAndCache(ConfigNode rootNode) async {
    final ExtractConfigMetadata extractor =
        ref.read(extractConfigMetadataProvider);

    // Extract plugin name from file path
    String? pluginName;
    final String fileName = configFilePath.split('/').last.split('\\').last;
    if (fileName.endsWith('.json')) {
      pluginName = fileName.substring(0, fileName.length - 5);
    }

    final Either<Failure, List<FieldMetadata>> result =
        await extractor.extractMetadata(rootNode, pluginName: pluginName);

    result.fold(
      (Failure failure) {
        // Error extracting - keep empty cache
      },
      (List<FieldMetadata> metadata) {
        // Cache metadata by field path for quick lookup
        final Map<String, List<FieldMetadata>> cache = <String, List<FieldMetadata>>{};
        for (final FieldMetadata meta in metadata) {
          final String path = meta.fieldPath;
          if (!cache.containsKey(path)) {
            cache[path] = <FieldMetadata>[];
          }
          cache[path]!.add(meta);
          // Debug logging for shortname fields
          if (path.toLowerCase().contains('short')) {
            debugPrint('💾 CACHE: Storing metadata for "$path"');
            debugPrint('   - widgetHint: ${meta.widgetHint?.type}');
            debugPrint('   - useRustItemsApi: ${meta.widgetHint?.useRustItemsApi}');
          }
        }
        debugPrint('💾 CACHE: Stored ${cache.length} field paths');
        state = cache;
      },
    );
  }

  /// Gets metadata for a specific field path.
  FieldMetadata? getMetadataForPath(String fieldPath) {
    final List<FieldMetadata>? metadataList = state[fieldPath];
    if (metadataList == null || metadataList.isEmpty) {
      return null;
    }
    // Return the metadata with highest confidence
    metadataList.sort((FieldMetadata a, FieldMetadata b) =>
        b.confidence.compareTo(a.confidence));
    return metadataList.first;
  }
}

