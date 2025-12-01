import 'package:flutter/material.dart';

import '../../../../core/theme/design_tokens.dart';
import '../../../metadata_management/domain/entities/field_metadata.dart';
import '../../../metadata_management/domain/entities/metadata_constraint.dart';

/// A card widget that displays a label with expandable help information.
///
/// When help is available, clicking the help icon expands a panel showing:
/// - Description/tooltip
/// - Constraints (min/max values, patterns, etc.)
/// - Example values (for dropdowns/enums)
class ExpandableHelpCard extends StatefulWidget {
  /// Creates a new ExpandableHelpCard.
  const ExpandableHelpCard({
    required this.label,
    required this.child,
    this.metadata,
    super.key,
  });

  /// The field label text.
  final String label;

  /// The input widget to display.
  final Widget child;

  /// Optional metadata for help information.
  final FieldMetadata? metadata;

  @override
  State<ExpandableHelpCard> createState() => _ExpandableHelpCardState();
}

class _ExpandableHelpCardState extends State<ExpandableHelpCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late final AnimationController _animationController;
  late final Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  bool get _hasHelp =>
      widget.metadata?.description != null ||
      widget.metadata?.tooltip != null ||
      (widget.metadata?.constraints.isNotEmpty ?? false) ||
      (widget.metadata?.allowedValues?.isNotEmpty ?? false);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Label row with help button
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                widget.label,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            if (_hasHelp) ...<Widget>[
              const SizedBox(width: DesignTokens.space100),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _toggleExpanded,
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(DesignTokens.space50),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        AnimatedRotation(
                          turns: _isExpanded ? 0.5 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          child: Icon(
                            _isExpanded ? Icons.help : Icons.help_outline,
                            size: 18,
                            color: _isExpanded
                                ? DesignTokens.primaryColor
                                : DesignTokens.onSurfaceVariantColor,
                          ),
                        ),
                        if (_isExpanded) ...<Widget>[
                          const SizedBox(width: DesignTokens.space50),
                          Text(
                            'Hide Help',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: DesignTokens.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),

        // Expandable help content
        SizeTransition(
          sizeFactor: _expandAnimation,
          axisAlignment: -1.0,
          child: Container(
            margin: const EdgeInsets.only(
              top: DesignTokens.space100,
              bottom: DesignTokens.space200,
            ),
            padding: const EdgeInsets.all(DesignTokens.space200),
            decoration: BoxDecoration(
              color: DesignTokens.primaryColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(DesignTokens.radiusMedium),
              border: Border.all(
                color: DesignTokens.primaryColor.withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Description
                if (widget.metadata?.description != null ||
                    widget.metadata?.tooltip != null) ...<Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Icon(
                        Icons.info_outline,
                        size: 18,
                        color: DesignTokens.primaryColor,
                      ),
                      const SizedBox(width: DesignTokens.space100),
                      Expanded(
                        child: Text(
                          widget.metadata!.description ??
                              widget.metadata!.tooltip!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ],

                // Constraints
                if (widget.metadata?.constraints.isNotEmpty ?? false) ...<Widget>[
                  const SizedBox(height: DesignTokens.space150),
                  _buildConstraintsInfo(widget.metadata!.constraints),
                ],

                // Allowed values
                if (widget.metadata?.allowedValues?.isNotEmpty ?? false) ...<Widget>[
                  const SizedBox(height: DesignTokens.space150),
                  _buildExamplesChips(widget.metadata!.allowedValues!),
                ],

                // Default value
                if (widget.metadata?.defaultValue != null) ...<Widget>[
                  const SizedBox(height: DesignTokens.space150),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.restore,
                        size: 16,
                        color: DesignTokens.onSurfaceVariantColor,
                      ),
                      const SizedBox(width: DesignTokens.space100),
                      Text(
                        'Default: ${widget.metadata!.defaultValue}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: DesignTokens.onSurfaceVariantColor,
                              fontStyle: FontStyle.italic,
                            ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),

        const SizedBox(height: DesignTokens.space100),

        // Input widget
        widget.child,
      ],
    );
  }

  Widget _buildConstraintsInfo(List<MetadataConstraint> constraints) {
    final List<Widget> chips = <Widget>[];

    for (final MetadataConstraint constraint in constraints) {
      switch (constraint.type) {
        case ConstraintType.minValue:
          if (constraint.minValue != null) {
            chips.add(_buildConstraintChip(
              icon: Icons.arrow_upward,
              label: 'Min: ${constraint.minValue}',
              color: DesignTokens.successColor,
            ));
          }
        case ConstraintType.maxValue:
          if (constraint.maxValue != null) {
            chips.add(_buildConstraintChip(
              icon: Icons.arrow_downward,
              label: 'Max: ${constraint.maxValue}',
              color: DesignTokens.errorColor,
            ));
          }
        case ConstraintType.range:
          if (constraint.minValue != null || constraint.maxValue != null) {
            chips.add(_buildConstraintChip(
              icon: Icons.unfold_more,
              label: 'Range: ${constraint.minValue ?? '-∞'} to ${constraint.maxValue ?? '∞'}',
              color: DesignTokens.primaryColor,
            ));
          }
        case ConstraintType.minLength:
          if (constraint.minLength != null) {
            chips.add(_buildConstraintChip(
              icon: Icons.text_fields,
              label: 'Min length: ${constraint.minLength}',
              color: DesignTokens.successColor,
            ));
          }
        case ConstraintType.maxLength:
          if (constraint.maxLength != null) {
            chips.add(_buildConstraintChip(
              icon: Icons.text_fields,
              label: 'Max length: ${constraint.maxLength}',
              color: DesignTokens.errorColor,
            ));
          }
        case ConstraintType.lengthRange:
          if (constraint.minLength != null || constraint.maxLength != null) {
            chips.add(_buildConstraintChip(
              icon: Icons.text_fields,
              label: 'Length: ${constraint.minLength ?? 0} - ${constraint.maxLength ?? '∞'}',
              color: DesignTokens.primaryColor,
            ));
          }
        case ConstraintType.pattern:
          if (constraint.pattern != null) {
            chips.add(_buildConstraintChip(
              icon: Icons.pattern,
              label: 'Pattern: ${constraint.pattern}',
              color: DesignTokens.warningColor,
            ));
          }
        case ConstraintType.required:
          chips.add(_buildConstraintChip(
            icon: Icons.star,
            label: 'Required',
            color: DesignTokens.errorColor,
          ));
        default:
          break;
      }
    }

    if (chips.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Constraints:',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: DesignTokens.onSurfaceVariantColor,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: DesignTokens.space100),
        Wrap(
          spacing: DesignTokens.space100,
          runSpacing: DesignTokens.space100,
          children: chips,
        ),
      ],
    );
  }

  Widget _buildConstraintChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.space150,
        vertical: DesignTokens.space50,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: const BorderRadius.all(Radius.circular(DesignTokens.radiusSmall)),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 14, color: color),
          const SizedBox(width: DesignTokens.space50),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExamplesChips(List<dynamic> values) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Valid values:',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: DesignTokens.onSurfaceVariantColor,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: DesignTokens.space100),
        Wrap(
          spacing: DesignTokens.space100,
          runSpacing: DesignTokens.space100,
          children: values.take(8).map<Widget>((dynamic v) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.space150,
                vertical: DesignTokens.space50,
              ),
              decoration: BoxDecoration(
                color: DesignTokens.primaryColor.withValues(alpha: 0.1),
                borderRadius: const BorderRadius.all(Radius.circular(DesignTokens.radiusSmall)),
                border: Border.all(
                  color: DesignTokens.primaryColor.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                v.toString(),
                style: const TextStyle(
                  fontSize: 11,
                  color: DesignTokens.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
        if (values.length > 8) ...<Widget>[
          const SizedBox(height: DesignTokens.space50),
          Text(
            '+ ${values.length - 8} more...',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: DesignTokens.onSurfaceVariantColor,
                  fontStyle: FontStyle.italic,
                ),
          ),
        ],
      ],
    );
  }
}
