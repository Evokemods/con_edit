import 'package:equatable/equatable.dart';

import '../../features/config_editor/domain/entities/config_node.dart';

/// Base class for commands in the command pattern (for undo/redo).
abstract class Command extends Equatable {
  /// Creates a new command.
  const Command();

  /// Executes the command and returns the updated config node.
  ConfigNode execute(ConfigNode rootNode);

  /// Undoes the command and returns the previous config node.
  ConfigNode undo(ConfigNode rootNode);

  /// Returns a description of what this command does.
  String get description;
}

/// Command for updating a field value.
class UpdateValueCommand extends Command {
  /// Creates a new update value command.
  const UpdateValueCommand({
    required this.path,
    required this.newValue,
    required this.oldValue,
  });

  /// Path to the field being updated.
  final List<String> path;

  /// New value.
  final dynamic newValue;

  /// Old value (for undo).
  final dynamic oldValue;

  @override
  ConfigNode execute(ConfigNode rootNode) {
    return _updateNode(rootNode, path, newValue);
  }

  @override
  ConfigNode undo(ConfigNode rootNode) {
    return _updateNode(rootNode, path, oldValue);
  }

  ConfigNode _updateNode(ConfigNode node, List<String> path, dynamic value) {
    if (path.isEmpty) {
      return node.copyWith(value: value);
    }

    final String key = path.first;
    final List<String> remainingPath = path.sublist(1);

    final List<ConfigNode> children = node.children.map((ConfigNode child) {
      if (child.key == key) {
        return _updateNode(child, remainingPath, value);
      }
      return child;
    }).toList();

    return node.copyWith(children: children);
  }

  @override
  String get description => 'Update ${path.join(".")}';

  @override
  List<Object?> get props => <Object?>[path, newValue, oldValue];
}

/// Command for adding a child node.
class AddChildCommand extends Command {
  /// Creates a new add child command.
  const AddChildCommand({
    required this.parentPath,
    required this.child,
  });

  /// Path to the parent node.
  final List<String> parentPath;

  /// Child node to add.
  final ConfigNode child;

  @override
  ConfigNode execute(ConfigNode rootNode) {
    return _addChild(rootNode, parentPath, child);
  }

  @override
  ConfigNode undo(ConfigNode rootNode) {
    return _removeChild(rootNode, parentPath, child.key);
  }

  ConfigNode _addChild(ConfigNode node, List<String> path, ConfigNode child) {
    if (path.isEmpty) {
      return node.copyWith(children: <ConfigNode>[...node.children, child]);
    }

    final String key = path.first;
    final List<String> remainingPath = path.sublist(1);

    final List<ConfigNode> children = node.children.map((ConfigNode c) {
      if (c.key == key) {
        return _addChild(c, remainingPath, child);
      }
      return c;
    }).toList();

    return node.copyWith(children: children);
  }

  ConfigNode _removeChild(ConfigNode node, List<String> path, String? childKey) {
    if (path.isEmpty) {
      return node.copyWith(
        children: node.children.where((ConfigNode c) => c.key != childKey).toList(),
      );
    }

    final String key = path.first;
    final List<String> remainingPath = path.sublist(1);

    final List<ConfigNode> children = node.children.map((ConfigNode c) {
      if (c.key == key) {
        return _removeChild(c, remainingPath, childKey);
      }
      return c;
    }).toList();

    return node.copyWith(children: children);
  }

  @override
  String get description => 'Add ${child.key ?? "item"}';

  @override
  List<Object?> get props => <Object?>[parentPath, child];
}

/// Command for removing a child node.
class RemoveChildCommand extends Command {
  /// Creates a new remove child command.
  const RemoveChildCommand({
    required this.parentPath,
    required this.childKey,
    required this.removedChild,
  });

  /// Path to the parent node.
  final List<String> parentPath;

  /// Key of the child to remove.
  final String? childKey;

  /// The removed child (for undo).
  final ConfigNode removedChild;

  @override
  ConfigNode execute(ConfigNode rootNode) {
    return _removeChild(rootNode, parentPath, childKey);
  }

  @override
  ConfigNode undo(ConfigNode rootNode) {
    return _addChild(rootNode, parentPath, removedChild);
  }

  ConfigNode _removeChild(ConfigNode node, List<String> path, String? childKey) {
    if (path.isEmpty) {
      return node.copyWith(
        children: node.children.where((ConfigNode c) => c.key != childKey).toList(),
      );
    }

    final String key = path.first;
    final List<String> remainingPath = path.sublist(1);

    final List<ConfigNode> children = node.children.map((ConfigNode c) {
      if (c.key == key) {
        return _removeChild(c, remainingPath, childKey);
      }
      return c;
    }).toList();

    return node.copyWith(children: children);
  }

  ConfigNode _addChild(ConfigNode node, List<String> path, ConfigNode child) {
    if (path.isEmpty) {
      return node.copyWith(children: <ConfigNode>[...node.children, child]);
    }

    final String key = path.first;
    final List<String> remainingPath = path.sublist(1);

    final List<ConfigNode> children = node.children.map((ConfigNode c) {
      if (c.key == key) {
        return _addChild(c, remainingPath, child);
      }
      return c;
    }).toList();

    return node.copyWith(children: children);
  }

  @override
  String get description => 'Remove ${childKey ?? "item"}';

  @override
  List<Object?> get props => <Object?>[parentPath, childKey, removedChild];
}
