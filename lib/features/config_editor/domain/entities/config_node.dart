import 'package:equatable/equatable.dart';

import 'config_value_type.dart';

/// Represents a node in the generic config tree structure.
///
/// This is the core entity for representing any JSON config in a tree format.
/// Each node can be a primitive value, an array, or an object with children.
class ConfigNode extends Equatable {
  /// Creates a new config node.
  const ConfigNode({
    required this.key,
    required this.valueType,
    this.value,
    this.children = const <ConfigNode>[],
    this.parent,
    this.path = const <String>[],
  });

  /// The key/name of this node (null for array elements and root).
  final String? key;

  /// The type of value this node represents.
  final ConfigValueType valueType;

  /// The actual value (for primitive types).
  final dynamic value;

  /// Child nodes (for arrays and objects).
  final List<ConfigNode> children;

  /// Reference to the parent node (null for root).
  final ConfigNode? parent;

  /// The path from root to this node (for navigation and breadcrumbs).
  final List<String> path;

  /// Returns true if this node is the root node.
  bool get isRoot => parent == null;

  /// Returns true if this node is a leaf (primitive value with no children).
  bool get isLeaf => children.isEmpty && valueType.isPrimitive;

  /// Returns the full path as a string (e.g., "player.inventory.items[0].name").
  String get fullPath => path.join('.');

  /// Returns the depth level of this node in the tree.
  int get depth => path.length;

  /// Creates a copy of this node with updated fields.
  ConfigNode copyWith({
    String? key,
    ConfigValueType? valueType,
    dynamic value,
    List<ConfigNode>? children,
    ConfigNode? parent,
    List<String>? path,
  }) {
    return ConfigNode(
      key: key ?? this.key,
      valueType: valueType ?? this.valueType,
      value: value ?? this.value,
      children: children ?? this.children,
      parent: parent ?? this.parent,
      path: path ?? this.path,
    );
  }

  /// Finds a child node by key.
  ConfigNode? findChild(String childKey) {
    return children.cast<ConfigNode?>().firstWhere(
          (ConfigNode? child) => child?.key == childKey,
          orElse: () => null as ConfigNode?,
        );
  }

  /// Returns all descendant nodes (recursive).
  List<ConfigNode> get descendants {
    final List<ConfigNode> result = <ConfigNode>[];
    for (final ConfigNode child in children) {
      result.add(child);
      result.addAll(child.descendants);
    }
    return result;
  }

  @override
  List<Object?> get props => <Object?>[key, valueType, value, children, path];

  @override
  String toString() {
    return 'ConfigNode(key: $key, type: $valueType, value: $value, children: ${children.length})';
  }
}
