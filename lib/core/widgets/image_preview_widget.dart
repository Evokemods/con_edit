import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../theme/design_tokens.dart';

/// Widget that displays an image preview from a URL.
///
/// Shows a thumbnail of the image with options to view full size.
class ImagePreviewWidget extends StatefulWidget {
  /// Creates a new ImagePreviewWidget.
  const ImagePreviewWidget({
    required this.imageUrl,
    this.thumbnailSize = 80,
    super.key,
  });

  /// The URL of the image to preview.
  final String imageUrl;

  /// Size of the thumbnail in pixels.
  final double thumbnailSize;

  @override
  State<ImagePreviewWidget> createState() => _ImagePreviewWidgetState();
}

class _ImagePreviewWidgetState extends State<ImagePreviewWidget> {
  bool _hasError = false;
  bool _isLoading = true;
  bool _timeoutReached = false;
  String? _errorMessage;
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  void didUpdateWidget(ImagePreviewWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset state and reload if URL changes
    if (oldWidget.imageUrl != widget.imageUrl) {
      setState(() {
        _hasError = false;
        _isLoading = true;
        _timeoutReached = false;
        _errorMessage = null;
        _imageBytes = null;
      });
      _loadImage();
    }
  }

  Future<void> _loadImage() async {
    if (widget.imageUrl.isEmpty) return;

    debugPrint('🖼️ Loading image: ${widget.imageUrl}');

    try {
      // Use http package with timeout
      final http.Response response = await http
          .get(Uri.parse(widget.imageUrl))
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw Exception('Image load timeout (10s)');
            },
          );

      if (!mounted) return;

      if (response.statusCode == 200) {
        debugPrint('✅ Image loaded successfully: ${widget.imageUrl}');
        setState(() {
          _imageBytes = response.bodyBytes;
          _isLoading = false;
          _hasError = false;
        });
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      debugPrint('❌ Image load error: ${widget.imageUrl}');
      debugPrint('   Error: $e');

      if (!mounted) return;

      setState(() {
        _hasError = true;
        _isLoading = false;
        _timeoutReached = e.toString().contains('timeout');
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrl.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(top: DesignTokens.space100),
      padding: const EdgeInsets.all(DesignTokens.space100),
      decoration: BoxDecoration(
        color: DesignTokens.surfaceVariantColor,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMedium),
        border: Border.all(
          color: DesignTokens.dividerColor,
        ),
      ),
      child: Row(
        children: <Widget>[
          // Thumbnail
          GestureDetector(
            onTap: () => _showFullSizeImage(context),
            child: Container(
              width: widget.thumbnailSize,
              height: widget.thumbnailSize,
              decoration: BoxDecoration(
                color: DesignTokens.backgroundColor,
                borderRadius: BorderRadius.circular(DesignTokens.radiusSmall),
                border: Border.all(
                  color: DesignTokens.dividerColor,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(DesignTokens.radiusSmall),
                child: _hasError
                    ? _buildErrorPlaceholder()
                    : _isLoading
                        ? _buildLoadingPlaceholder()
                        : _imageBytes != null
                            ? _buildImage()
                            : _buildLoadingPlaceholder(),
              ),
            ),
          ),

          const SizedBox(width: DesignTokens.space200),

          // Info and actions
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.image_outlined,
                      size: 16,
                      color: DesignTokens.onSurfaceVariantColor,
                    ),
                    const SizedBox(width: DesignTokens.space50),
                    Text(
                      'Image Preview',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: DesignTokens.onSurfaceVariantColor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: DesignTokens.space50),
                Text(
                  _truncateUrl(widget.imageUrl),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: DesignTokens.onSurfaceVariantColor,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: DesignTokens.space100),
                Wrap(
                  spacing: DesignTokens.space100,
                  children: <Widget>[
                    _buildActionButton(
                      icon: Icons.open_in_new,
                      label: 'View Full Size',
                      onPressed: () => _showFullSizeImage(context),
                    ),
                    _buildActionButton(
                      icon: Icons.refresh,
                      label: 'Reload',
                      onPressed: () {
                        setState(() {
                          _hasError = false;
                          _isLoading = true;
                          _timeoutReached = false;
                          _errorMessage = null;
                          _imageBytes = null;
                        });
                        _loadImage();
                      },
                    ),
                    _buildActionButton(
                      icon: Icons.copy,
                      label: 'Copy URL',
                      onPressed: () => _copyUrlToClipboard(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (_imageBytes == null) {
      return _buildLoadingPlaceholder();
    }

    return Image.memory(
      _imageBytes!,
      fit: BoxFit.cover,
      cacheWidth: (widget.thumbnailSize * 2).toInt(), // Cache at 2x resolution
      cacheHeight: (widget.thumbnailSize * 2).toInt(),
      errorBuilder: (
        BuildContext context,
        Object error,
        StackTrace? stackTrace,
      ) {
        debugPrint('❌ Image decode error: ${widget.imageUrl}');
        debugPrint('   Error: $error');
        return _buildErrorPlaceholder();
      },
    );
  }

  Widget _buildLoadingPlaceholder() {
    return const Center(
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            DesignTokens.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildErrorPlaceholder() {
    return Tooltip(
      message: _errorMessage ?? 'Failed to load image',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              _timeoutReached ? Icons.access_time : Icons.broken_image_outlined,
              size: 32,
              color: DesignTokens.onSurfaceVariantColor,
            ),
            const SizedBox(height: DesignTokens.space50),
            Text(
              _timeoutReached ? 'Timeout' : 'Failed',
              style: const TextStyle(
                fontSize: 10,
                color: DesignTokens.onSurfaceVariantColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 14),
      label: Text(label),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.space150,
          vertical: DesignTokens.space50,
        ),
        textStyle: const TextStyle(fontSize: 11),
        visualDensity: VisualDensity.compact,
      ),
    );
  }

  void _showFullSizeImage(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: <Widget>[
              // Fullscreen image
              Center(
                child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: _imageBytes != null
                      ? Image.memory(
                          _imageBytes!,
                          errorBuilder: (
                            BuildContext context,
                            Object error,
                            StackTrace? stackTrace,
                          ) {
                            return Container(
                              padding: const EdgeInsets.all(DesignTokens.space400),
                              decoration: BoxDecoration(
                                color: DesignTokens.surfaceColor,
                                borderRadius: BorderRadius.circular(
                                  DesignTokens.radiusMedium,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Icon(
                                    Icons.broken_image_outlined,
                                    size: 64,
                                    color: DesignTokens.errorColor,
                                  ),
                                  const SizedBox(height: DesignTokens.space200),
                                  Text(
                                    'Failed to load image',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: DesignTokens.space100),
                                  Text(
                                    widget.imageUrl,
                                    style: Theme.of(context).textTheme.bodySmall,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : Container(
                          padding: const EdgeInsets.all(DesignTokens.space400),
                          decoration: BoxDecoration(
                            color: DesignTokens.surfaceColor,
                            borderRadius: BorderRadius.circular(
                              DesignTokens.radiusMedium,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Icon(
                                Icons.broken_image_outlined,
                                size: 64,
                                color: DesignTokens.errorColor,
                              ),
                              const SizedBox(height: DesignTokens.space200),
                              Text(
                                'Image not loaded',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                ),
              ),

              // Close button
              Positioned(
                top: 16,
                right: 16,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, color: Colors.white),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black54,
                  ),
                ),
              ),

              // URL display at bottom
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.all(DesignTokens.space200),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(
                      DesignTokens.radiusMedium,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.link,
                        size: 16,
                        color: Colors.white70,
                      ),
                      const SizedBox(width: DesignTokens.space100),
                      Expanded(
                        child: Text(
                          widget.imageUrl,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _truncateUrl(String url) {
    if (url.length <= 50) return url;
    return '${url.substring(0, 47)}...';
  }

  Future<void> _copyUrlToClipboard(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: widget.imageUrl));

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: <Widget>[
              Icon(
                Icons.check_circle,
                color: DesignTokens.successColor,
                size: 18,
              ),
              SizedBox(width: DesignTokens.space100),
              Text('Image URL copied to clipboard'),
            ],
          ),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: DesignTokens.surfaceColor,
        ),
      );
    }
  }
}
