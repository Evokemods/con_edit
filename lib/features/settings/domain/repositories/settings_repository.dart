import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/app_settings.dart';

/// Repository interface for settings operations.
abstract class SettingsRepository {
  /// Loads application settings.
  Future<Either<Failure, AppSettings>> loadSettings();

  /// Saves application settings.
  Future<Either<Failure, void>> saveSettings(AppSettings settings);

  /// Updates a specific setting.
  Future<Either<Failure, void>> updateSetting<T>(
    String key,
    T value,
  );
}
