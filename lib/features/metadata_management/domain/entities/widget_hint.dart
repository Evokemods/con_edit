import 'package:equatable/equatable.dart';

/// Hint for which widget to use for rendering a field.
class WidgetHint extends Equatable {
  /// Creates a new widget hint.
  const WidgetHint({
    required this.type,
    this.showSlider = false,
    this.sliderMin,
    this.sliderMax,
    this.sliderDivisions,
    this.isMultiLine = false,
    this.showRichText = false,
    this.showCanvas = false,
    this.canvasType,
    this.useRustItemsApi = false,
  });

  /// Type of widget to use.
  final WidgetType type;

  /// Whether to show a slider for numeric values.
  final bool showSlider;

  /// Minimum value for slider.
  final num? sliderMin;

  /// Maximum value for slider.
  final num? sliderMax;

  /// Number of divisions for slider.
  final int? sliderDivisions;

  /// Whether to use multi-line text input.
  final bool isMultiLine;

  /// Whether to show rich text editor.
  final bool showRichText;

  /// Whether to show canvas/visual editor.
  final bool showCanvas;

  /// Type of canvas (e.g., "map", "spawn_points", "zones").
  final String? canvasType;

  /// Whether to use Rust items API for autocomplete.
  final bool useRustItemsApi;

  @override
  List<Object?> get props => <Object?>[
        type,
        showSlider,
        sliderMin,
        sliderMax,
        sliderDivisions,
        isMultiLine,
        showRichText,
        showCanvas,
        canvasType,
        useRustItemsApi,
      ];
}

/// Types of widgets available for rendering.
enum WidgetType {
  /// Text input field.
  textField,

  /// Multi-line text area.
  textArea,

  /// Rich text editor.
  richText,

  /// Numeric input.
  numericInput,

  /// Slider for numeric values.
  slider,

  /// Switch for boolean values.
  switch_,

  /// Dropdown/select for enums.
  dropdown,

  /// Autocomplete input.
  autocomplete,

  /// List editor for arrays.
  listEditor,

  /// Table editor for arrays of objects.
  tableEditor,

  /// Collapsible section for objects.
  collapsibleSection,

  /// Canvas/visual editor for spatial data.
  canvas,

  /// Vector3 input (3 number fields).
  vector3,

  /// Preset selector.
  presetSelector,

  /// Color picker for hex color values.
  colorPicker,
}
