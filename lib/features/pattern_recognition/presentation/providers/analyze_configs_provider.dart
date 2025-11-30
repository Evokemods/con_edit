import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/pattern_repository_impl.dart';
import '../../domain/usecases/analyze_configs.dart';

/// Provider for PatternRepository.
final Provider<PatternRepositoryImpl> patternRepositoryProvider =
    Provider<PatternRepositoryImpl>((Ref ref) {
  // This will be provided via override in main
  throw UnimplementedError('PatternRepository must be provided via override');
});

/// Provider for AnalyzeConfigs use case.
final Provider<AnalyzeConfigs> analyzeConfigsProvider =
    Provider<AnalyzeConfigs>((Ref ref) {
  final PatternRepositoryImpl repository = ref.watch(patternRepositoryProvider);
  return AnalyzeConfigs(repository);
});

