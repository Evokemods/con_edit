import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/open_file.dart';
import '../../domain/usecases/save_file.dart';

/// Provider for the OpenFile use case.
final Provider<OpenFile> openFileProvider = Provider<OpenFile>((Ref ref) {
  // This will be provided via override in main
  throw UnimplementedError('OpenFile must be provided via override');
});

/// Provider for the SaveFile use case.
final Provider<SaveFile> saveFileProvider = Provider<SaveFile>((Ref ref) {
  // This will be provided via override in main
  throw UnimplementedError('SaveFile must be provided via override');
});
