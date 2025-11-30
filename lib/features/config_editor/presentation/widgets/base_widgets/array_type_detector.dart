import '../../../domain/entities/config_node.dart';
import '../../../domain/entities/config_value_type.dart';

/// Detects the type and purpose of an array to show appropriate UI.
enum ArrayType {
  /// Array of Rust item shortnames/prefabs.
  rustItems,

  /// Array of string messages/commands.
  strings,

  /// Array of numbers (integers or doubles).
  numbers,

  /// Array of objects (complex nested structures).
  objects,

  /// Array of booleans.
  booleans,

  /// Mixed or unknown type.
  mixed,
}

/// Detector for array types and purposes.
class ArrayTypeDetector {
  /// Detects the array type based on field name and content.
  static ArrayType detectArrayType(ConfigNode node) {
    final String fieldName = (node.key?.toLowerCase() ?? '');

    // Check field name patterns first (most reliable)
    if (_isItemArray(fieldName)) {
      return ArrayType.rustItems;
    }

    if (_isStringArray(fieldName)) {
      return ArrayType.strings;
    }

    if (_isNumberArray(fieldName)) {
      return ArrayType.numbers;
    }

    // If array has children, infer from content
    if (node.children.isNotEmpty) {
      return _inferFromContent(node);
    }

    // Default to mixed if we can't determine
    return ArrayType.mixed;
  }

  /// Checks if field name suggests this is an item/prefab array.
  static bool _isItemArray(String fieldName) {
    final List<String> itemPatterns = <String>[
      'item',
      'items',
      'prefab',
      'prefabs',
      'shortname',
      'shortnames',
      'container',
      'containers',
      'skin',
      'skins',
      'skin id',
      'skin list',
      'allowed containers',
      'block from',
      'blacklist',
      'whitelist',
    ];

    return itemPatterns.any((String pattern) => fieldName.contains(pattern));
  }

  /// Checks if field name suggests this is a string array.
  static bool _isStringArray(String fieldName) {
    final List<String> stringPatterns = <String>[
      'message',
      'messages',
      'command',
      'commands',
      'text',
      'string',
      'hook',
      'hooks',
      'name',
      'names',
      'title',
      'titles',
      'description',
      'descriptions',
    ];

    return stringPatterns.any((String pattern) => fieldName.contains(pattern));
  }

  /// Checks if field name suggests this is a number array.
  static bool _isNumberArray(String fieldName) {
    final List<String> numberPatterns = <String>[
      'id',
      'ids',
      'multiplier',
      'multipliers',
      'chance',
      'chances',
      'roll',
      'rolls',
      'value',
      'values',
      'number',
      'numbers',
      'amount',
      'amounts',
    ];

    return numberPatterns.any((String pattern) => fieldName.contains(pattern));
  }

  /// Infers array type from existing content.
  static ArrayType _inferFromContent(ConfigNode node) {
    if (node.children.isEmpty) {
      return ArrayType.mixed;
    }

    // Check if all children are the same type
    final ConfigValueType firstType = node.children.first.valueType;
    final bool allSameType = node.children.every(
      (ConfigNode child) => child.valueType == firstType,
    );

    if (!allSameType) {
      return ArrayType.mixed;
    }

    // Determine type based on first child
    switch (firstType) {
      case ConfigValueType.string:
        // Check if strings look like item shortnames
        if (node.children.any((ConfigNode child) {
          final String? value = child.value?.toString();
          if (value == null) return false;
          // Item shortnames typically have dots or underscores
          return value.contains('.') || value.contains('_');
        })) {
          // Could be items, but check field name too
          final String fieldName = (node.key?.toLowerCase() ?? '');
          if (_isItemArray(fieldName)) {
            return ArrayType.rustItems;
          }
        }
        return ArrayType.strings;

      case ConfigValueType.integer:
      case ConfigValueType.double:
        return ArrayType.numbers;

      case ConfigValueType.boolean:
        return ArrayType.booleans;

      case ConfigValueType.object:
        return ArrayType.objects;

      case ConfigValueType.array:
        return ArrayType.mixed; // Nested arrays

      case ConfigValueType.nullValue:
      case ConfigValueType.unknown:
        return ArrayType.mixed;
    }
  }

  /// Gets a user-friendly description of the array type.
  static String getArrayTypeDescription(ArrayType type) {
    switch (type) {
      case ArrayType.rustItems:
        return 'Rust Items';
      case ArrayType.strings:
        return 'Text List';
      case ArrayType.numbers:
        return 'Number List';
      case ArrayType.objects:
        return 'Object List';
      case ArrayType.booleans:
        return 'Boolean List';
      case ArrayType.mixed:
        return 'Mixed Array';
    }
  }

  /// Gets appropriate hint text for the array type.
  static String getHintText(ArrayType type, String? fieldName) {
    final String fieldNameLower = (fieldName?.toLowerCase() ?? '');
    
    switch (type) {
      case ArrayType.rustItems:
        return 'Search Rust items... (e.g., "campfire", "ak")';
      case ArrayType.strings:
        if (fieldNameLower.contains('command')) {
          return 'Enter command (e.g., "/shop", "/bank")';
        }
        if (fieldNameLower.contains('message')) {
          return 'Enter message text...';
        }
        return 'Enter text...';
      case ArrayType.numbers:
        return 'Enter number...';
      case ArrayType.objects:
        return 'Add new object';
      case ArrayType.booleans:
        return 'Add boolean value';
      case ArrayType.mixed:
        return 'Enter value...';
    }
  }
}

