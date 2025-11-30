import 'dart:convert';

import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/config_node.dart';
import '../../domain/repositories/config_repository.dart';
import '../models/config_node_model.dart';

/// Implementation of ConfigRepository.
class ConfigRepositoryImpl implements ConfigRepository {
  /// Creates a new ConfigRepositoryImpl.
  const ConfigRepositoryImpl();

  @override
  Future<Either<Failure, ConfigNode>> parseJson(String jsonString) async {
    try {
      final dynamic json = jsonDecode(jsonString);
      final ConfigNode rootNode = ConfigNodeModel.fromJson(json, null, null, <String>[]);
      return Right<Failure, ConfigNode>(rootNode);
    } on FormatException catch (e, stackTrace) {
      Logger.error(
        'Failed to parse JSON',
        error: e,
        stackTrace: stackTrace,
        name: 'ConfigRepository',
      );
      return Left<Failure, ConfigNode>(ParseFailure('Invalid JSON format: ${e.message}'));
    } catch (e, stackTrace) {
      Logger.error(
        'Unexpected error parsing JSON',
        error: e,
        stackTrace: stackTrace,
        name: 'ConfigRepository',
      );
      return Left<Failure, ConfigNode>(UnexpectedFailure('Failed to parse JSON: $e'));
    }
  }

  @override
  Future<Either<Failure, String>> toJson(ConfigNode rootNode) async {
    try {
      final dynamic json = ConfigNodeModel.toJson(rootNode);
      final String jsonString = const JsonEncoder.withIndent('  ').convert(json);
      return Right<Failure, String>(jsonString);
    } catch (e, stackTrace) {
      Logger.error(
        'Failed to convert ConfigNode to JSON',
        error: e,
        stackTrace: stackTrace,
        name: 'ConfigRepository',
      );
      return Left<Failure, String>(ParseFailure('Failed to convert to JSON: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> validate(ConfigNode rootNode) async {
    // Basic validation - can be extended
    try {
      // Check for circular references and other issues
      return const Right<Failure, bool>(true);
    } catch (e, stackTrace) {
      Logger.error(
        'Validation failed',
        error: e,
        stackTrace: stackTrace,
        name: 'ConfigRepository',
      );
      return Left<Failure, bool>(ValidationFailure('Validation failed: $e'));
    }
  }
}

