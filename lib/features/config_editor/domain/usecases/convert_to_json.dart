import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/config_node.dart';
import '../repositories/config_repository.dart';

/// Use case for converting a ConfigNode tree to JSON.
class ConvertToJson {
  /// Creates a new ConvertToJson use case.
  const ConvertToJson(this.repository);

  /// The config repository.
  final ConfigRepository repository;

  /// Converts a ConfigNode tree to JSON string.
  Future<Either<Failure, String>> call(ConfigNode rootNode) {
    return repository.toJson(rootNode);
  }
}

