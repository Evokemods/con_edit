import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/design_tokens.dart';
import '../../../../metadata_management/domain/entities/field_metadata.dart';
import '../../../../metadata_management/presentation/providers/config_metadata_provider.dart';
import '../../../domain/entities/config_node.dart';
import '../field_label_with_help.dart';

/// Widget for picking hex colors with visual preview.
class ColorPickerWidget extends ConsumerStatefulWidget {
  /// Creates a new ColorPickerWidget.
  const ColorPickerWidget({
    required this.node,
    required this.onChanged,
    super.key,
  });

  /// The config node to edit.
  final ConfigNode node;

  /// Callback when value changes.
  final ValueChanged<String> onChanged;

  @override
  ConsumerState<ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends ConsumerState<ColorPickerWidget> {
  late final TextEditingController _controller;
  Color? _currentColor;

  @override
  void initState() {
    super.initState();
    final String value = widget.node.value?.toString() ?? '';
    _controller = TextEditingController(text: value);
    _updateColorFromValue(value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ColorPickerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.node.value != widget.node.value) {
      final String value = widget.node.value?.toString() ?? '';
      _controller.text = value;
      _updateColorFromValue(value);
    }
  }

  /// Parses hex color string and updates the current color.
  void _updateColorFromValue(String value) {
    if (value.isEmpty) {
      setState(() => _currentColor = null);
      return;
    }

    try {
      // Handle formats: #RRGGBB, #RGB, RRGGBB, RGB
      String hex = value.trim();
      if (!hex.startsWith('#')) {
        hex = '#$hex';
      }

      // Expand short format #RGB to #RRGGBB
      if (hex.length == 4) {
        hex = '#${hex[1]}${hex[1]}${hex[2]}${hex[2]}${hex[3]}${hex[3]}';
      }

      // Parse hex color
      if (hex.length == 7) {
        final int colorValue = int.parse(hex.substring(1), radix: 16);
        setState(() {
          _currentColor = Color(0xFF000000 | colorValue);
        });
      } else {
        setState(() => _currentColor = null);
      }
    } catch (e) {
      setState(() => _currentColor = null);
    }
  }

  /// Converts Color to hex string.
  String _colorToHex(Color color) {
    final int a = ((color.a * 255.0).round() & 0xff);
    final int r = ((color.r * 255.0).round() & 0xff);
    final int g = ((color.g * 255.0).round() & 0xff);
    final int b = ((color.b * 255.0).round() & 0xff);
    final int argb = (a << 24) | (r << 16) | (g << 8) | b;
    return '#${argb.toRadixString(16).substring(2).toUpperCase()}';
  }

  /// Opens the color picker dialog.
  Future<void> _openColorPicker() async {
    final Color initialColor = _currentColor ?? Colors.black;
    final Color? pickedColor = await showDialog<Color>(
      context: context,
      builder: (BuildContext context) =>
          _ColorPickerDialog(initialColor: initialColor),
    );

    if (pickedColor != null) {
      final String hexValue = _colorToHex(pickedColor);
      _controller.text = hexValue;
      _updateColorFromValue(hexValue);
      widget.onChanged(hexValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get metadata for help
    final String fieldPath = widget.node.path.join('.');
    final FieldMetadata? metadata = ref.watch(fieldMetadataProvider(fieldPath));
    final bool isReadOnly = metadata?.isReadOnly ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (widget.node.key != null) ...<Widget>[
          FieldLabelWithHelp(label: widget.node.key!, metadata: metadata),
          const SizedBox(height: DesignTokens.space100),
        ],
        Row(
          children: <Widget>[
            // Color preview swatch
            GestureDetector(
              onTap: isReadOnly ? null : _openColorPicker,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _currentColor ?? Colors.grey[300],
                  borderRadius: BorderRadius.circular(DesignTokens.radiusSmall),
                  border: Border.all(
                    color: DesignTokens.dividerColor,
                    width: 2,
                  ),
                ),
                child: _currentColor == null
                    ? Icon(
                        Icons.color_lens_outlined,
                        color: Colors.grey[600],
                        size: 24,
                      )
                    : null,
              ),
            ),
            const SizedBox(width: DesignTokens.space200),
            // Hex input field
            Expanded(
              child: TextField(
                controller: _controller,
                enabled: !isReadOnly,
                readOnly: isReadOnly,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: 'monospace',
                  color: isReadOnly
                      ? Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.6)
                      : null,
                ),
                decoration: InputDecoration(
                  hintText: isReadOnly
                      ? 'Read-only (set by developer)'
                      : '#RRGGBB',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: DesignTokens.onSurfaceVariantColor,
                    fontFamily: 'monospace',
                  ),
                  prefixIcon: const Icon(
                    Icons.tag,
                    size: 18,
                    color: DesignTokens.onSurfaceVariantColor,
                  ),
                  suffixIcon: isReadOnly
                      ? Tooltip(
                          message:
                              'This field is read-only and managed by the plugin',
                          child: Icon(
                            Icons.lock_outline,
                            size: 18,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        )
                      : IconButton(
                          icon: const Icon(Icons.color_lens),
                          tooltip: 'Open color picker',
                          onPressed: _openColorPicker,
                        ),
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[#0-9A-Fa-f]')),
                ],
                onChanged: isReadOnly
                    ? null
                    : (String value) {
                        _updateColorFromValue(value);
                        widget.onChanged(value);
                      },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Dialog for picking colors.
class _ColorPickerDialog extends StatefulWidget {
  const _ColorPickerDialog({required this.initialColor});

  final Color initialColor;

  @override
  State<_ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<_ColorPickerDialog> {
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.initialColor;
  }

  /// Common preset colors for quick selection.
  static const List<Color> _presetColors = <Color>[
    Color(0xFF000000), // Black
    Color(0xFF1A1A1A), // Dark gray
    Color(0xFF333333), // Gray
    Color(0xFF666666), // Medium gray
    Color(0xFF999999), // Light gray
    Color(0xFFCCCCCC), // Lighter gray
    Color(0xFFFFFFFF), // White
    Color(0xFFFF0000), // Red
    Color(0xFFFF8500), // Orange
    Color(0xFFFFFF00), // Yellow
    Color(0xFF00FF00), // Green
    Color(0xFF00FFFF), // Cyan
    Color(0xFF0000FF), // Blue
    Color(0xFF8000FF), // Purple
    Color(0xFFFF00FF), // Magenta
    Color(0xFFFF6B6B), // Light red
    Color(0xFFFFA500), // Orange
    Color(0xFFFFD700), // Gold
    Color(0xFF90EE90), // Light green
    Color(0xFF87CEEB), // Sky blue
    Color(0xFF9370DB), // Medium purple
    Color(0xFFFF69B4), // Hot pink
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pick a Color'),
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Color picker
            SizedBox(
              height: 200,
              child: ColorPicker(
                color: _selectedColor,
                onColorChanged: (Color color) {
                  setState(() => _selectedColor = color);
                },
              ),
            ),
            const SizedBox(height: DesignTokens.space200),
            // Preset colors
            Wrap(
              spacing: DesignTokens.space100,
              runSpacing: DesignTokens.space100,
              children: _presetColors.map((Color color) {
                return GestureDetector(
                  onTap: () => setState(() => _selectedColor = color),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _selectedColor == color
                            ? DesignTokens.primaryColor
                            : DesignTokens.dividerColor,
                        width: _selectedColor == color ? 3 : 1,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: DesignTokens.space200),
            // Current color display
            Container(
              padding: const EdgeInsets.all(DesignTokens.space150),
              decoration: BoxDecoration(
                color: DesignTokens.surfaceVariantColor,
                borderRadius: BorderRadius.circular(DesignTokens.radiusSmall),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _selectedColor,
                      borderRadius: BorderRadius.circular(
                        DesignTokens.radiusSmall,
                      ),
                      border: Border.all(color: DesignTokens.dividerColor),
                    ),
                  ),
                  const SizedBox(width: DesignTokens.space200),
                  Builder(
                    builder: (BuildContext context) {
                      final int a = ((_selectedColor.a * 255.0).round() & 0xff);
                      final int r = ((_selectedColor.r * 255.0).round() & 0xff);
                      final int g = ((_selectedColor.g * 255.0).round() & 0xff);
                      final int b = ((_selectedColor.b * 255.0).round() & 0xff);
                      final int argb = (a << 24) | (r << 16) | (g << 8) | b;
                      return Text(
                        '#${argb.toRadixString(16).substring(2).toUpperCase()}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(_selectedColor),
          child: const Text('Select'),
        ),
      ],
    );
  }
}

/// Simple color picker widget.
class ColorPicker extends StatefulWidget {
  /// Creates a new ColorPicker.
  const ColorPicker({
    required this.color,
    required this.onColorChanged,
    super.key,
  });

  /// The initial color to display.
  final Color color;

  /// Callback when the color changes.
  final ValueChanged<Color> onColorChanged;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late HSVColor _hsvColor;

  @override
  void initState() {
    super.initState();
    _hsvColor = HSVColor.fromColor(widget.color);
  }

  @override
  void didUpdateWidget(ColorPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color != widget.color) {
      _hsvColor = HSVColor.fromColor(widget.color);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Hue slider
        Row(
          children: <Widget>[
            const Text('Hue:', style: TextStyle(fontSize: 12)),
            Expanded(
              child: Slider(
                value: _hsvColor.hue,
                max: 360,
                divisions: 360,
                label: _hsvColor.hue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _hsvColor = _hsvColor.withHue(value);
                  });
                  widget.onColorChanged(_hsvColor.toColor());
                },
              ),
            ),
          ],
        ),
        // Saturation slider
        Row(
          children: <Widget>[
            const Text('Sat:', style: TextStyle(fontSize: 12)),
            Expanded(
              child: Slider(
                value: _hsvColor.saturation,
                divisions: 100,
                label: (_hsvColor.saturation * 100).round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _hsvColor = _hsvColor.withSaturation(value);
                  });
                  widget.onColorChanged(_hsvColor.toColor());
                },
              ),
            ),
          ],
        ),
        // Value/Brightness slider
        Row(
          children: <Widget>[
            const Text('Val:', style: TextStyle(fontSize: 12)),
            Expanded(
              child: Slider(
                value: _hsvColor.value,
                divisions: 100,
                label: (_hsvColor.value * 100).round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _hsvColor = _hsvColor.withValue(value);
                  });
                  widget.onColorChanged(_hsvColor.toColor());
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
