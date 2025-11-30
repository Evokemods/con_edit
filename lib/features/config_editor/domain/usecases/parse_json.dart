import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/config_node.dart';
import '../repositories/config_repository.dart';

/// Use case for parsing JSON into a ConfigNode tree.
class ParseJson {
  /// Creates a new ParseJson use case.
  const ParseJson(this.repository);

  /// The config repository.
  final ConfigRepository repository;

  /// Parses a JSON string into a ConfigNode tree.
  Future<Either<Failure, ConfigNode>> call(String jsonString) {
    return repository.parseJson(jsonString);
  }
}

