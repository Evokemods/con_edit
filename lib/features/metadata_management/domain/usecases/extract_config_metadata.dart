import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../config_editor/domain/entities/config_node.dart';
import '../../../config_editor/domain/entities/config_value_type.dart';
import '../../domain/entities/field_metadata.dart';
import '../../domain/entities/metadata_constraint.dart';
import '../../domain/entities/widget_hint.dart';
import 'plugin_knowledge_base.dart';
import 'rust_field_knowledge_base.dart';

/// Use case for extracting metadata from config files.
///
/// Analyzes config structure and field names to extract:
/// - Descriptions embedded in field names (e.g., "Enable X [description]")
/// - Type hints from values
/// - Range constraints from comments and patterns
/// - Enum values from allowed options
class ExtractConfigMetadata {
  /// Extracts metadata from a config node tree.
  Future<Either<Failure, List<FieldMetadata>>> extractMetadata(
    ConfigNode rootNode, {
    String? pluginName,
  }) async {
    try {
      final List<FieldMetadata> metadata = <FieldMetadata>[];
      await _extractFromNode(rootNode, '', metadata, pluginName: pluginName);
      return Right<Failure, List<FieldMetadata>>(metadata);
    } on Object catch (e) {
      return Left<Failure, List<FieldMetadata>>(
        UnexpectedFailure('Failed to extract metadata: $e'),
      );
    }
  }

  /// Recursively extracts metadata from a node and its children.
  Future<void> _extractFromNode(
    ConfigNode node,
    String currentPath,
    List<FieldMetadata> metadata, {
    String? pluginName,
  }) async {
    // Use node.path.join('.') to match what the widget uses for lookup
    // This ensures paths are consistent and don't have duplicates
    final String fieldPath = node.path.join('.');

    // Extract metadata from field name
    final FieldMetadata? extracted = _extractFromFieldName(
      node,
      fieldPath,
      pluginName: pluginName,
    );

    if (extracted != null) {
      metadata.add(extracted);
    }

    // Recursively process children
    for (final ConfigNode child in node.children) {
      await _extractFromNode(child, '', metadata, pluginName: pluginName);
    }
  }

  /// Extracts metadata from a field name.
  ///
  /// Rust plugin configs often embed descriptions in field names like:
  /// - "Enable X [description text]"
  /// - "Field name (description)"
  /// - "Field name [0% - 100%]"
  /// - "Field name [option1 | option2 | option3]"
  FieldMetadata? _extractFromFieldName(
    ConfigNode node,
    String fieldPath, {
    String? pluginName,
  }) {
    final String? fieldName = node.key;
    if (fieldName == null) return null;

    String? description;
    String? tooltip;
    List<dynamic>? allowedValues;
    WidgetHint? widgetHint;
    String? autocompleteSource;
    String? imagePreviewUrl;
    final List<MetadataConstraint> constraints = <MetadataConstraint>[];

    // First, check plugin-specific knowledge base, then generic Rust knowledge
    final FieldHelpInfo? knowledgeBaseHelp = PluginKnowledgeBase.getCombinedHelp(
      pluginName,
      fieldName,
      fieldPath,
    );
    bool isReadOnly = false;
    
    if (knowledgeBaseHelp != null) {
      // Use knowledge base description/tooltip as base
      description ??= knowledgeBaseHelp.description;
      tooltip ??= knowledgeBaseHelp.tooltip;
      isReadOnly = knowledgeBaseHelp.isReadOnly;

      // Add examples to tooltip if available
      if (knowledgeBaseHelp.examples.isNotEmpty && tooltip != null) {
        tooltip = '$tooltip\n\n${knowledgeBaseHelp.examplesText}';
      }
    }

    // Also check for version-related fields (case-insensitive)
    // Check field name, parent key, and field path for version context
    final String lowerFieldName = fieldName.toLowerCase();
    final String lowerFieldPath = fieldPath.toLowerCase();
    final String? parentKey = node.parent?.key?.toLowerCase();
    
    // Check if this is a version-related field
    final bool isVersionField = lowerFieldName == 'version' ||
        lowerFieldName == 'major' ||
        lowerFieldName == 'minor' ||
        lowerFieldName == 'patch';
    
    // Check if we're in a version context (parent is version, or path contains version)
    final bool isInVersionContext = parentKey == 'version' ||
        (parentKey != null && parentKey.contains('version')) ||
        lowerFieldPath.contains('.version.') ||
        lowerFieldPath.contains('.version[') ||
        lowerFieldPath.startsWith('version.') ||
        lowerFieldPath == 'version';
    
    if (isVersionField || isInVersionContext) {
      isReadOnly = true;
      description ??= 'Version number (read-only, set by developer)';
      tooltip ??= 'This version field is automatically managed by the plugin and should not be edited.';
    }

    // Extract description from brackets: "Field [description]"
    final RegExp bracketDesc = RegExp(r'^(.+?)\s*\[(.+?)\]$');
    final RegExp parenDesc = RegExp(r'^(.+?)\s*\((.+?)\)$');

    String? extractedDesc;

    // Try bracket format first: "Enable X [description]"
    final Match? bracketMatch = bracketDesc.firstMatch(fieldName);
    if (bracketMatch != null) {
      extractedDesc = bracketMatch.group(2)!.trim();

      // Check if it's a range: "[0% - 100%]" or "[0 - 100]"
      final RegExp rangePattern = RegExp(r'^(\d+(?:\.\d+)?)\s*-\s*(\d+(?:\.\d+)?)');
      final Match? rangeMatch = rangePattern.firstMatch(extractedDesc);
      if (rangeMatch != null) {
        final double min = double.parse(rangeMatch.group(1)!);
        final double max = double.parse(rangeMatch.group(2)!);
        constraints.add(
          MetadataConstraint(
            type: ConstraintType.range,
            minValue: min,
            maxValue: max,
          ),
        );
        description = 'Range: $min to $max';
      } else if (extractedDesc.contains('|')) {
        // Enum values: "[option1 | option2 | option3]"
        allowedValues = extractedDesc
            .split('|')
            .map<String>((String s) => s.trim())
            .toList();
        description = 'Allowed values: ${allowedValues.join(', ')}';
        widgetHint = const WidgetHint(type: WidgetType.dropdown);
      } else {
        // Regular description
        description = extractedDesc;
      }
    } else {
      // Try parenthesis format: "Field (description)"
      final Match? parenMatch = parenDesc.firstMatch(fieldName);
      if (parenMatch != null) {
        extractedDesc = parenMatch.group(2)!.trim();
        description = extractedDesc;
      }
    }

    // Extract Rust item hints (shortname fields)
    // Check for patterns like: shortname, short_name, short name, item, itemname, item name, etc.
    final String normalizedFieldName = fieldName.toLowerCase()
        .replaceAll('_', '')
        .replaceAll(' ', '')
        .replaceAll('-', '');

    final bool isItemField = normalizedFieldName == 'shortname' ||
        normalizedFieldName == 'shortnames' ||
        normalizedFieldName == 'item' ||
        normalizedFieldName == 'items' ||
        normalizedFieldName == 'itemname' ||
        normalizedFieldName == 'itemnames' ||
        normalizedFieldName == 'shortnameid' ||
        normalizedFieldName.contains('itemshort') ||
        normalizedFieldName.contains('rustitem') ||
        normalizedFieldName.endsWith('name') && normalizedFieldName.length <= 12;

    // Debug logging
    if (isItemField) {
      debugPrint('🔍 AUTOCOMPLETE: Detected item field: "$fieldName" (normalized: "$normalizedFieldName")');
      debugPrint('   - valueType: ${node.valueType}');
      debugPrint('   - value: ${node.value}');
      debugPrint('   - value runtimeType: ${node.value?.runtimeType}');
    }

    // Check if it's a string type OR if the field name strongly suggests it should be
    // (sometimes empty fields might not have a detected type yet)
    final bool shouldUseAutocomplete = isItemField &&
        (node.valueType == ConfigValueType.string ||
         node.valueType == ConfigValueType.unknown ||
         node.value == null ||
         node.value is String);

    if (shouldUseAutocomplete) {
      debugPrint('✅ AUTOCOMPLETE: Enabled for "$fieldName"');
      description ??= 'Rust item shortname';
      tooltip ??= 'The unique shortname for a Rust item (e.g., "rifle.ak", "wood", "scrap"). '
          'Type to search from the Rust items database.';
      widgetHint = const WidgetHint(
        type: WidgetType.autocomplete,
        useRustItemsApi: true,
      );

      // If we have a value, try to add it to the autocomplete source
      if (node.value is String) {
        autocompleteSource = 'rust_items';
      }
    }

    // Extract type hints from field name patterns
    if (fieldName.toLowerCase().contains('color') ||
        fieldName.toLowerCase().contains('colour') ||
        fieldName.toLowerCase() == 'hex' ||
        fieldName.toLowerCase() == 'hexcolor') {
      if (node.valueType == ConfigValueType.string) {
        // Check if it's a hex color
        if (node.value is String) {
          final String value = node.value as String;
          if (value.startsWith('#') ||
              RegExp(r'^[0-9A-Fa-f]{6}$').hasMatch(value) ||
              RegExp(r'^[0-9A-Fa-f]{3}$').hasMatch(value)) {
            widgetHint = const WidgetHint(type: WidgetType.colorPicker);
            constraints.add(
              const MetadataConstraint(
                type: ConstraintType.pattern,
                pattern: r'^#?[0-9A-Fa-f]{3,6}$',
              ),
            );
          } else {
            widgetHint ??= const WidgetHint(type: WidgetType.autocomplete);
          }
        } else {
          // Field name suggests color but no value yet - assume hex color
          widgetHint = const WidgetHint(type: WidgetType.colorPicker);
        }
      }
    }

    // Extract URL/image hints with preview support
    if (fieldName.toLowerCase().contains('url') ||
        fieldName.toLowerCase().contains('image') ||
        fieldName.toLowerCase().contains('icon') ||
        fieldName.toLowerCase().contains('logo')) {
      widgetHint ??= const WidgetHint(type: WidgetType.textField);
      if (node.valueType == ConfigValueType.string) {
        constraints.add(
          const MetadataConstraint(
            type: ConstraintType.pattern,
            pattern: r'^https?://.+',
          ),
        );

        // If we have a value that looks like an image URL, store it for preview
        if (node.value is String) {
          final String urlValue = node.value as String;
          if (urlValue.startsWith('http') &&
              (urlValue.toLowerCase().endsWith('.png') ||
               urlValue.toLowerCase().endsWith('.jpg') ||
               urlValue.toLowerCase().endsWith('.jpeg') ||
               urlValue.toLowerCase().endsWith('.gif') ||
               urlValue.toLowerCase().endsWith('.webp'))) {
            imagePreviewUrl = urlValue;
          }
        }
      }
    }

    // Extract permission hints
    if (fieldName.toLowerCase().contains('permission')) {
      widgetHint ??= const WidgetHint(type: WidgetType.autocomplete);
    }

    // Extract command hints
    if (fieldName.toLowerCase().contains('command')) {
      widgetHint ??= const WidgetHint(type: WidgetType.textField);
    }

    // Extract time/seconds hints
    if (fieldName.toLowerCase().contains('seconds') ||
        fieldName.toLowerCase().contains('duration') ||
        fieldName.toLowerCase().contains('cooldown') ||
        fieldName.toLowerCase().contains('interval')) {
      if (node.valueType.isNumeric) {
        constraints.add(
          const MetadataConstraint(
            type: ConstraintType.range,
            minValue: 0,
            maxValue: double.infinity,
          ),
        );
        description ??= 'Time in seconds';
      }
    }

    // Extract percentage hints
    if (fieldName.toLowerCase().contains('percent') ||
        fieldName.toLowerCase().contains('%') ||
        fieldName.toLowerCase().contains('opacity')) {
      if (node.valueType.isNumeric) {
        constraints.add(
          const MetadataConstraint(
            type: ConstraintType.range,
            minValue: 0,
            maxValue: 100,
          ),
        );
        description ??= 'Percentage value (0-100)';
        widgetHint ??= const WidgetHint(
          type: WidgetType.slider,
          showSlider: true,
          sliderMin: 0,
          sliderMax: 100,
        );
      }
    }

    // Extract boolean hints
    if (fieldName.toLowerCase().startsWith('enable') ||
        fieldName.toLowerCase().startsWith('disable') ||
        fieldName.toLowerCase().startsWith('allow') ||
        fieldName.toLowerCase().startsWith('use') ||
        fieldName.toLowerCase().contains('?') ||
        (node.valueType == ConfigValueType.boolean)) {
      widgetHint ??= const WidgetHint(type: WidgetType.switch_);
      description ??= 'Enable or disable this feature';
    }

    // Extract distance/position hints
    if (fieldName.toLowerCase().contains('distance') ||
        fieldName.toLowerCase().contains('offset') ||
        fieldName.toLowerCase().contains('position') ||
        fieldName.toLowerCase().contains('scale') ||
        fieldName.toLowerCase().contains('size')) {
      if (node.valueType.isNumeric) {
        description ??= 'Numeric value';
      }
    }

    // Infer constraints from actual values
    if (node.valueType.isNumeric && node.value != null) {
      final double numValue = (node.value as num).toDouble();
      // If we don't have a range constraint yet, infer from value
      if (constraints.where((MetadataConstraint c) => c.type == ConstraintType.range).isEmpty) {
        if (numValue >= 0 && numValue <= 1) {
          // Likely a probability or normalized value
          constraints.add(
            const MetadataConstraint(
              type: ConstraintType.range,
              minValue: 0,
              maxValue: 1,
            ),
          );
        } else if (numValue >= 0 && numValue <= 100) {
          // Likely a percentage
          constraints.add(
            const MetadataConstraint(
              type: ConstraintType.range,
              minValue: 0,
              maxValue: 100,
            ),
          );
        }
      }
    }

    // Only create metadata if we have useful information
    // Always include if we have knowledge base help, even if no other info extracted
    if (knowledgeBaseHelp == null &&
        description == null &&
        allowedValues == null &&
        widgetHint == null &&
        constraints.isEmpty) {
      return null;
    }

    return FieldMetadata(
      fieldPath: fieldPath,
      description: description,
      tooltip: tooltip ?? description,
      valueType: node.valueType,
      constraints: constraints,
      widgetHint: widgetHint,
      allowedValues: allowedValues,
      defaultValue: node.value,
      autocompleteSource: autocompleteSource,
      imagePreviewUrl: imagePreviewUrl,
      confidence: 0.8, // High confidence for extracted metadata
      isReadOnly: isReadOnly,
    );
  }
}

