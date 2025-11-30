import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/config_node.dart';

/// Repository interface for config operations.
///
/// This is part of the domain layer and defines the contract for
/// parsing and manipulating config files.
abstract class ConfigRepository {
  /// Parses a JSON string into a ConfigNode tree.
  Future<Either<Failure, ConfigNode>> parseJson(String jsonString);

  /// Converts a ConfigNode tree back to JSON string.
  Future<Either<Failure, String>> toJson(ConfigNode rootNode);

  /// Validates a ConfigNode tree structure.
  Future<Either<Failure, bool>> validate(ConfigNode rootNode);
}
