import 'package:flutter/material.dart';

import '../../../config_editor/domain/entities/config_node.dart';
import '../../../config_editor/domain/entities/config_value_type.dart';
import '../../../config_editor/presentation/widgets/base_widgets/array_widget.dart';
import '../../../config_editor/presentation/widgets/base_widgets/boolean_input_widget.dart';
import '../../../config_editor/presentation/widgets/base_widgets/color_picker_widget.dart';
import '../../../config_editor/presentation/widgets/base_widgets/dropdown_widget.dart';
import '../../../config_editor/presentation/widgets/base_widgets/multiline_text_widget.dart';
import '../../../config_editor/presentation/widgets/base_widgets/numeric_input_widget.dart';
import '../../../config_editor/presentation/widgets/base_widgets/object_widget.dart';
import '../../../config_editor/presentation/widgets/base_widgets/rust_item_autocomplete_widget.dart';
import '../../../config_editor/presentation/widgets/base_widgets/string_input_widget.dart';
import '../../domain/entities/field_metadata.dart';
import '../../domain/entities/widget_hint.dart';
import 'validation_service.dart';

/// Service for selecting appropriate widgets based on metadata and node type.
class WidgetSelector {
  /// Selects the appropriate widget for a config node.
  ///
  /// First checks metadata hints, then falls back to type-based selection.
  /// Also validates the node and displays any errors.
  static Widget selectWidget({
    required ConfigNode node,
    required ValueChanged<ConfigNode> onChanged,
    FieldMetadata? metadata,
  }) {
    // Validate the node
    final List<String> validationErrors =
        ValidationService.validateNode(node, metadata);

    Widget widget;

    // Debug logging
    if (node.key != null && node.key!.toLowerCase().contains('short')) {
      debugPrint('🔧 WIDGET SELECTOR: ${node.key}');
      debugPrint('   - metadata: ${metadata != null ? "exists" : "null"}');
      debugPrint('   - widgetHint: ${metadata?.widgetHint}');
      debugPrint('   - widgetHint.type: ${metadata?.widgetHint?.type}');
      debugPrint('   - useRustItemsApi: ${metadata?.widgetHint?.useRustItemsApi}');
    }

    // If metadata has widget hint, use that
    if (metadata?.widgetHint != null) {
      debugPrint('   - Using hint-based widget');
      widget = _buildFromHint(
        node: node,
        hint: metadata!.widgetHint!,
        metadata: metadata,
        validationErrors: validationErrors,
        onChanged: onChanged,
      );
    } else {
      debugPrint('   - Using type-based widget');
      // Otherwise, fall back to type-based selection
      widget = _buildFromType(
        node: node,
        metadata: metadata,
        validationErrors: validationErrors,
        onChanged: onChanged,
      );
    }

    return widget;
  }

  /// Builds widget based on metadata hint.
  static Widget _buildFromHint({
    required ConfigNode node,
    required WidgetHint hint,
    required FieldMetadata metadata,
    required List<String> validationErrors,
    required ValueChanged<ConfigNode> onChanged,
  }) {
    switch (hint.type) {
      case WidgetType.textField:
        return StringInputWidget(
          node: node,
          onChanged: (String value) => onChanged(node.copyWith(value: value)),
        );

      case WidgetType.textArea:
        return MultilineTextWidget(
          node: node,
          onChanged: onChanged,
          validationErrors: validationErrors,
        );

      case WidgetType.numericInput:
        return NumericInputWidget(
          node: node,
          onChanged: (num value) => onChanged(node.copyWith(value: value)),
        );

      case WidgetType.slider:
        // Slider support: fallback to numeric input for now
        // Future enhancement: implement SliderWidget with min/max from metadata
        return NumericInputWidget(
          node: node,
          onChanged: (num value) => onChanged(node.copyWith(value: value)),
        );

      case WidgetType.switch_:
        return BooleanInputWidget(
          node: node,
          onChanged: (bool value) => onChanged(node.copyWith(value: value)),
        );

      case WidgetType.dropdown:
        if (metadata.allowedValues != null &&
            metadata.allowedValues!.isNotEmpty) {
          return DropdownWidget(
            node: node,
            allowedValues: metadata.allowedValues!,
            onChanged: onChanged,
            validationErrors: validationErrors,
          );
        }
        // Fall back to string input if no allowed values
        return StringInputWidget(
          node: node,
          onChanged: (String value) => onChanged(node.copyWith(value: value)),
        );

      case WidgetType.listEditor:
        return ArrayWidget(
          node: node,
          onNodeChanged: onChanged,
        );

      case WidgetType.collapsibleSection:
        return ObjectWidget(
          node: node,
          onNodeChanged: onChanged,
        );

      // Advanced widgets: fallback to type-based selection
      // Future enhancements: richText, autocomplete, tableEditor, canvas, vector3, presetSelector
      case WidgetType.richText:
      case WidgetType.colorPicker:
        return ColorPickerWidget(
          node: node,
          onChanged: (String value) => onChanged(node.copyWith(value: value)),
        );

      case WidgetType.autocomplete:
        debugPrint('   - In autocomplete case');
        debugPrint('   - useRustItemsApi: ${hint.useRustItemsApi}');
        debugPrint('   - node.valueType: ${node.valueType}');
        // Check if this is a Rust items autocomplete
        if (hint.useRustItemsApi && node.valueType == ConfigValueType.string) {
          debugPrint('   - ✅ Returning RustItemAutocompleteWidget');
          return RustItemAutocompleteWidget(
            node: node,
            onChanged: (String value) => onChanged(node.copyWith(value: value)),
          );
        }
        // Fall back to regular string input for other autocomplete types
        debugPrint('   - ⚠️ Falling back to StringInputWidget');
        return StringInputWidget(
          node: node,
          onChanged: (String value) => onChanged(node.copyWith(value: value)),
        );

      case WidgetType.tableEditor:
      case WidgetType.canvas:
      case WidgetType.vector3:
      case WidgetType.presetSelector:
        return _buildFromType(
          node: node,
          metadata: metadata,
          validationErrors: validationErrors,
          onChanged: onChanged,
        );
    }
  }

  /// Builds widget based on node type.
  static Widget _buildFromType({
    required ConfigNode node,
    FieldMetadata? metadata,
    required List<String> validationErrors,
    required ValueChanged<ConfigNode> onChanged,
  }) {
    // Check if metadata has allowed values for dropdown
    if (metadata?.allowedValues != null &&
        metadata!.allowedValues!.isNotEmpty &&
        node.valueType.isPrimitive) {
      return DropdownWidget(
        node: node,
        allowedValues: metadata.allowedValues!,
        onChanged: onChanged,
        validationErrors: validationErrors,
      );
    }

    switch (node.valueType) {
      case ConfigValueType.string:
        // Check for multi-line hint
        if (metadata?.widgetHint?.isMultiLine ?? false) {
          return MultilineTextWidget(
            node: node,
            onChanged: onChanged,
            validationErrors: validationErrors,
          );
        }
        // Check if value looks like a hex color
        if (node.value is String) {
          final String value = node.value as String;
          if (value.startsWith('#') || 
              RegExp(r'^[0-9A-Fa-f]{6}$').hasMatch(value) ||
              RegExp(r'^[0-9A-Fa-f]{3}$').hasMatch(value)) {
            return ColorPickerWidget(
              node: node,
              onChanged: (String hexValue) => onChanged(node.copyWith(value: hexValue)),
            );
          }
        }
        return StringInputWidget(
          node: node,
          onChanged: (String value) => onChanged(node.copyWith(value: value)),
        );

      case ConfigValueType.integer:
      case ConfigValueType.double:
        // Numeric input: slider support can be added via metadata widget hints
        return NumericInputWidget(
          node: node,
          onChanged: (num value) => onChanged(node.copyWith(value: value)),
        );

      case ConfigValueType.boolean:
        return BooleanInputWidget(
          node: node,
          onChanged: (bool value) => onChanged(node.copyWith(value: value)),
        );

      case ConfigValueType.unknown:
        return Text('Unknown type: ${node.valueType}');

      case ConfigValueType.array:
        return ArrayWidget(
          node: node,
          onNodeChanged: onChanged,
        );

      case ConfigValueType.object:
        return ObjectWidget(
          node: node,
          onNodeChanged: onChanged,
        );

      case ConfigValueType.nullValue:
        return const SizedBox.shrink();
    }
  }
}
