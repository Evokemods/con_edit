import 'package:equatable/equatable.dart';

/// Base class for all failures in the application.
///
/// Failures represent errors that can occur during use cases execution.
/// They are part of the domain layer and should not contain implementation details.
abstract class Failure extends Equatable {
  /// Creates a new failure with an optional message.
  const Failure([this.message]);

  /// Error message describing the failure.
  final String? message;

  @override
  List<Object?> get props => <Object?>[message];
}

/// Failure related to file operations.
class FileFailure extends Failure {
  /// Creates a new file failure.
  const FileFailure([super.message]);
}

/// Failure related to JSON parsing.
class ParseFailure extends Failure {
  /// Creates a new parse failure.
  const ParseFailure([super.message]);
}

/// Failure related to validation.
class ValidationFailure extends Failure {
  /// Creates a new validation failure.
  const ValidationFailure([super.message]);
}

/// Failure related to database operations.
class DatabaseFailure extends Failure {
  /// Creates a new database failure.
  const DatabaseFailure([super.message]);
}

/// Failure related to network operations.
class NetworkFailure extends Failure {
  /// Creates a new network failure.
  const NetworkFailure([super.message]);
}

/// Failure when metadata is not found.
class MetadataNotFoundFailure extends Failure {
  /// Creates a new metadata not found failure.
  const MetadataNotFoundFailure([super.message]);
}

/// Failure when a requested resource is not found.
class NotFoundFailure extends Failure {
  /// Creates a new not found failure.
  const NotFoundFailure([super.message]);
}

/// Failure for unexpected errors.
class UnexpectedFailure extends Failure {
  /// Creates a new unexpected failure.
  const UnexpectedFailure([super.message]);
}
