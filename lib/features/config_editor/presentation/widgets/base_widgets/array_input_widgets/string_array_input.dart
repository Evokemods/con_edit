import 'package:flutter/material.dart';

import '../../../../../../core/theme/design_tokens.dart';

/// Specialized input widget for string arrays.
class StringArrayInput extends StatelessWidget {
  /// Creates a new StringArrayInput.
  const StringArrayInput({
    required this.onAdd,
    this.hintText,
    super.key,
  });

  /// Callback when user wants to add a string.
  final ValueChanged<String> onAdd;

  /// Optional hint text.
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return _StringArrayInputStateful(
      onAdd: onAdd,
      hintText: hintText,
    );
  }
}

class _StringArrayInputStateful extends StatefulWidget {
  const _StringArrayInputStateful({
    required this.onAdd,
    this.hintText,
  });

  final ValueChanged<String> onAdd;
  final String? hintText;

  @override
  State<_StringArrayInputStateful> createState() =>
      _StringArrayInputStatefulState();
}

class _StringArrayInputStatefulState
    extends State<_StringArrayInputStateful> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleAdd() {
    final String value = _controller.text.trim();
    if (value.isNotEmpty) {
      widget.onAdd(value);
      _controller.clear();
      _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: widget.hintText ?? 'Enter text...',
              isDense: true,
              prefixIcon: const Icon(Icons.text_fields),
              suffixIcon: _controller.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _controller.clear();
                        setState(() {});
                      },
                    )
                  : null,
            ),
            onChanged: (String _) => setState(() {}),
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
    );
  }
}

