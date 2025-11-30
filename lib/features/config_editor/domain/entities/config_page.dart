import 'package:equatable/equatable.dart';

import 'config_node.dart';

/// Represents a page/section in the config editor.
///
/// Each page groups related config nodes together for easier navigation.
class ConfigPage extends Equatable {
  /// Creates a new config page.
  const ConfigPage({
    required this.name,
    required this.nodes,
    this.description,
  });

  /// The name/title of this page.
  final String name;

  /// Optional description of what this page contains.
  final String? description;

  /// The config nodes displayed on this page.
  final List<ConfigNode> nodes;

  /// Extracts pages from a root ConfigNode.
  ///
  /// Top-level object children become individual pages.
  /// Loose primitive fields go into a "General" page.
  static List<ConfigPage> fromRootNode(ConfigNode rootNode) {
    final List<ConfigPage> pages = <ConfigPage>[];
    final List<ConfigNode> looseNodes = <ConfigNode>[];

    // Separate object nodes from loose primitives
    for (final ConfigNode child in rootNode.children) {
      if (child.valueType.isCollection) {
        // Objects and arrays become their own pages
        pages.add(
          ConfigPage(
            name: child.key ?? 'Unnamed Section',
            nodes: <ConfigNode>[child],
          ),
        );
      } else {
        // Primitives go to General page
        looseNodes.add(child);
      }
    }

    // Add General page at the beginning if there are loose nodes
    if (looseNodes.isNotEmpty) {
      pages.insert(
        0,
        ConfigPage(
          name: 'General',
          description: 'General configuration settings',
          nodes: looseNodes,
        ),
      );
    }

    return pages;
  }

  @override
  List<Object?> get props => <Object?>[name, description, nodes];

  @override
  String toString() {
    return 'ConfigPage(name: $name, nodes: ${nodes.length})';
  }
}
