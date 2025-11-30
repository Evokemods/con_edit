import '../../domain/entities/config_node.dart';
import '../../domain/entities/config_value_type.dart';

/// Model for serializing/deserializing ConfigNode to/from JSON.
class ConfigNodeModel {
  /// Creates a ConfigNode from a JSON value.
  /// Uses a two-phase approach: first creates the structure, then fixes parent references.
  static ConfigNode fromJson(
    dynamic json,
    String? key,
    ConfigNode? parent,
    List<String> path,
  ) {
    final ConfigNode node = _createNodeStructure(json, key, parent, path);
    return _fixParentReferences(node, parent);
  }

  /// Creates the node structure without proper parent references in children.
  static ConfigNode _createNodeStructure(
    dynamic json,
    String? key,
    ConfigNode? parent,
    List<String> path,
  ) {
    if (json == null) {
      return ConfigNode(
        key: key,
        valueType: ConfigValueType.nullValue,
        parent: parent,
        path: path,
      );
    }

    if (json is bool) {
      return ConfigNode(
        key: key,
        valueType: ConfigValueType.boolean,
        value: json,
        parent: parent,
        path: path,
      );
    }

    if (json is int) {
      return ConfigNode(
        key: key,
        valueType: ConfigValueType.integer,
        value: json,
        parent: parent,
        path: path,
      );
    }

    if (json is double) {
      return ConfigNode(
        key: key,
        valueType: ConfigValueType.double,
        value: json,
        parent: parent,
        path: path,
      );
    }

    if (json is String) {
      return ConfigNode(
        key: key,
        valueType: ConfigValueType.string,
        value: json,
        parent: parent,
        path: path,
      );
    }

    if (json is List) {
      final List<ConfigNode> children = <ConfigNode>[];
      for (int i = 0; i < json.length; i++) {
        final List<String> childPath = <String>[...path, '[$i]'];
        // Create children with null parent first, will fix in _fixParentReferences
        children.add(_createNodeStructure(json[i], null, null, childPath));
      }
      final ConfigNode node = ConfigNode(
        key: key,
        valueType: ConfigValueType.array,
        children: children,
        parent: parent,
        path: path,
      );
      // Fix children's parent references
      return _fixParentReferences(node, parent);
    }

    if (json is Map<String, dynamic>) {
      final List<ConfigNode> children = <ConfigNode>[];
      for (final MapEntry<String, dynamic> entry in json.entries) {
        final List<String> childPath = <String>[...path, entry.key];
        // Create children with null parent first, will fix in _fixParentReferences
        children.add(_createNodeStructure(entry.value, entry.key, null, childPath));
      }
      final ConfigNode node = ConfigNode(
        key: key,
        valueType: ConfigValueType.object,
        children: children,
        parent: parent,
        path: path,
      );
      // Fix children's parent references
      return _fixParentReferences(node, parent);
    }

    return ConfigNode(
      key: key,
      valueType: ConfigValueType.unknown,
      value: json.toString(),
      parent: parent,
      path: path,
    );
  }

  /// Fixes parent references in a node and all its children recursively.
  static ConfigNode _fixParentReferences(ConfigNode node, ConfigNode? parent) {
    if (node.children.isEmpty) {
      // Leaf node - just update parent if needed
      if (node.parent != parent) {
        return node.copyWith(parent: parent);
      }
      return node;
    }

    // Fix children's parent references first
    final List<ConfigNode> fixedChildren = node.children.map(
      (ConfigNode child) => _fixParentReferences(child, node),
    ).toList();

    // Update this node with fixed children and parent
    return node.copyWith(
      children: fixedChildren,
      parent: parent,
    );
  }

  /// Converts a ConfigNode to JSON.
  static dynamic toJson(ConfigNode node) {
    switch (node.valueType) {
      case ConfigValueType.nullValue:
        return null;
      case ConfigValueType.boolean:
      case ConfigValueType.integer:
      case ConfigValueType.double:
      case ConfigValueType.string:
        return node.value;
      case ConfigValueType.array:
        return node.children.map<dynamic>((ConfigNode child) => toJson(child)).toList();
      case ConfigValueType.object:
        final Map<String, dynamic> map = <String, dynamic>{};
        for (final ConfigNode child in node.children) {
          if (child.key != null) {
            map[child.key!] = toJson(child);
          }
        }
        return map;
      case ConfigValueType.unknown:
        return node.value;
    }
  }
}

