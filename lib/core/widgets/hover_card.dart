import 'package:flutter/material.dart';

import '../theme/design_tokens.dart';

/// A card widget that provides visual feedback on hover.
///
/// When hovered:
/// - Border becomes primaryColor with 0.5 alpha
/// - Box shadow appears with glow effect
/// - Smooth 200ms animation
class HoverCard extends StatefulWidget {
  /// Creates a new HoverCard.
  const HoverCard({
    required this.child,
    this.padding,
    super.key,
  });

  /// The child widget to display.
  final Widget child;

  /// Padding inside the card.
  final EdgeInsetsGeometry? padding;

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: DesignTokens.animationDuration,
        padding: widget.padding ?? const EdgeInsets.all(DesignTokens.space200),
        decoration: BoxDecoration(
          color: DesignTokens.surfaceColor,
          borderRadius: BorderRadius.circular(DesignTokens.radiusMedium),
          border: Border.all(
            color: _isHovered
                ? DesignTokens.primaryColor.withValues(alpha: 0.5)
                : Colors.transparent,
            width: 2,
          ),
          boxShadow: _isHovered
              ? <BoxShadow>[
                  BoxShadow(
                    color: DesignTokens.primaryColor.withValues(alpha: 0.2),
                    blurRadius: DesignTokens.hoverBlurRadius,
                  ),
                ]
              : null,
        ),
        child: widget.child,
      ),
    );
  }
}
