import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../config_editor/presentation/providers/config_provider.dart';
import '../../domain/entities/field_metadata.dart';
import '../../domain/usecases/get_field_metadata.dart';

/// Provider for GetFieldMetadata use case.
final Provider<GetFieldMetadata?> getFieldMetadataProvider =
    Provider<GetFieldMetadata?>((Ref ref) {
  // Will be provided via override in main
  return null;
});

/// Provider for metadata lookup by field path.
///
/// Usage: ref.watch(fieldMetadataProvider('player.health'))
final FutureProviderFamily<FieldMetadata?, String> fieldMetadataProvider =
    FutureProvider.family<FieldMetadata?, String>(
  (Ref ref, String fieldPath) async {
    final GetFieldMetadata? useCase = ref.watch(getFieldMetadataProvider);
    if (useCase == null) return null;

    // Get current file path from config editor state
    final String? configFilePath = ref.watch(
      configEditorProvider.select((ConfigEditorState state) => state.currentFilePath),
    );

    // Skip metadata lookup if no file is loaded
    if (configFilePath == null || configFilePath.isEmpty) {
      return null;
    }

    final Either<Failure, FieldMetadata?> result = await useCase(
      configFilePath: configFilePath,
      fieldPath: fieldPath,
    );

    return result.fold(
      (Failure failure) => null,
      (FieldMetadata? metadata) => metadata,
    );
  },
);

/// State for metadata-driven UI.
class MetadataUiState {
  /// Creates a new MetadataUiState.
  const MetadataUiState({
    this.showTooltips = true,
    this.showValidationErrors = true,
    this.useMetadataHints = true,
  });

  /// Whether to show metadata tooltips.
  final bool showTooltips;

  /// Whether to show validation errors inline.
  final bool showValidationErrors;

  /// Whether to use metadata hints for widget selection.
  final bool useMetadataHints;

  /// Creates a copy with updated fields.
  MetadataUiState copyWith({
    bool? showTooltips,
    bool? showValidationErrors,
    bool? useMetadataHints,
  }) {
    return MetadataUiState(
      showTooltips: showTooltips ?? this.showTooltips,
      showValidationErrors: showValidationErrors ?? this.showValidationErrors,
      useMetadataHints: useMetadataHints ?? this.useMetadataHints,
    );
  }
}

/// Notifier for metadata UI settings.
class MetadataUiNotifier extends StateNotifier<MetadataUiState> {
  /// Creates a new MetadataUiNotifier.
  MetadataUiNotifier() : super(const MetadataUiState());

  /// Toggles tooltip visibility.
  void toggleTooltips() {
    state = state.copyWith(showTooltips: !state.showTooltips);
  }

  /// Toggles validation error visibility.
  void toggleValidationErrors() {
    state = state.copyWith(
      showValidationErrors: !state.showValidationErrors,
    );
  }

  /// Toggles metadata hint usage.
  void toggleMetadataHints() {
    state = state.copyWith(useMetadataHints: !state.useMetadataHints);
  }
}

/// Provider for metadata UI settings.
final StateNotifierProvider<MetadataUiNotifier, MetadataUiState>
    metadataUiProvider =
    StateNotifierProvider<MetadataUiNotifier, MetadataUiState>(
  (Ref ref) {
    return MetadataUiNotifier();
  },
);
