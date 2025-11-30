import 'package:flutter/material.dart';

import '../../../../../../core/theme/design_tokens.dart';
import '../../../../domain/entities/config_value_type.dart';

/// Specialized input widget for number arrays.
class NumberArrayInput extends StatelessWidget {
  /// Creates a new NumberArrayInput.
  const NumberArrayInput({
    required this.onAdd,
    this.hintText,
    this.valueType = ConfigValueType.double,
    super.key,
  });

  /// Callback when user wants to add a number.
  final ValueChanged<num> onAdd;

  /// Optional hint text.
  final String? hintText;

  /// Expected number type.
  final ConfigValueType valueType;

  @override
  Widget build(BuildContext context) {
    return _NumberArrayInputStateful(
      onAdd: onAdd,
      hintText: hintText,
      valueType: valueType,
    );
  }
}

class _NumberArrayInputStateful extends StatefulWidget {
  const _NumberArrayInputStateful({
    required this.onAdd,
    this.hintText,
    required this.valueType,
  });

  final ValueChanged<num> onAdd;
  final String? hintText;
  final ConfigValueType valueType;

  @override
  State<_NumberArrayInputStateful> createState() =>
      _NumberArrayInputStatefulState();
}

class _NumberArrayInputStatefulState
    extends State<_NumberArrayInputStateful> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String? _errorText;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleAdd() {
    final String value = _controller.text.trim();
    if (value.isEmpty) return;

    final num? number = widget.valueType == ConfigValueType.integer
        ? int.tryParse(value)
        : double.tryParse(value);

    if (number == null) {
      setState(() {
        _errorText = 'Please enter a valid number';
      });
      return;
    }

    setState(() {
      _errorText = null;
    });

    widget.onAdd(number);
    _controller.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: widget.hintText ?? 'Enter number...',
                  isDense: true,
                  prefixIcon: const Icon(Icons.numbers),
                  errorText: _errorText,
                  suffixIcon: _controller.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _controller.clear();
                            setState(() {
                              _errorText = null;
                            });
                          },
                        )
                      : null,
                ),
                onChanged: (String _) {
                  setState(() {
                    _errorText = null;
                  });
                },
                onSubmitted: (String _) => _handleAdd(),
                textInputAction: TextInputAction.done,
              ),
            ),
            const SizedBox(width: DesignTokens.space100),
            ElevatedButton.icon(
              onPressed: _controller.text.trim().isNotEmpty ? _handleAdd : null,
              icon: const Icon(Icons.add),
              label: const Text('Add'),
            ),
          ],
        ),
        if (_errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: DesignTokens.space50),
            child: Text(
              _errorText!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
          ),
      ],
    );
  }
}

