import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fuoday/core/constants/assets/app_assets_constants.dart';

class KCircularCachedImage extends StatelessWidget {
  final String imageUrl;
  final double size;
  final Widget? placeholder;
  final Widget? errorWidget;
  final BoxFit fit;
  final Color? borderColor;
  final double borderWidth;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final bool cacheBust; // <-- NEW

  const KCircularCachedImage({
    super.key,
    required this.imageUrl,
    this.size = 50.0,
    this.placeholder,
    this.errorWidget,
    this.fit = BoxFit.cover,
    this.borderColor,
    this.borderWidth = 0.0,
    this.backgroundColor,
    this.onTap,
    this.cacheBust = true, // <-- default true

  });

  @override
  Widget build(BuildContext context) {
    final isValidUrl =
        imageUrl.trim().isNotEmpty &&
        Uri.tryParse(imageUrl)?.hasAbsolutePath == true;

    // Add timestamp param if cacheBust enabled
    final finalUrl = cacheBust && isValidUrl
        ? "$imageUrl?ts=${DateTime.now().millisecondsSinceEpoch}"
        : imageUrl;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
          border: borderWidth > 0 && borderColor != null
              ? Border.all(color: borderColor!, width: borderWidth)
              : null,
        ),
        child: ClipOval(
          child: isValidUrl
              ? CachedNetworkImage(
                  imageUrl: finalUrl,
                  fit: fit,
                  placeholder: (context, url) => _buildPlaceholder(),
                  errorWidget: (context, url, error) => _buildErrorWidget(),
                )
              : _buildPlaceholder(),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return placeholder ??
        Image.asset(AppAssetsConstants.personPlaceHolderImg, fit: fit);
  }

  Widget _buildErrorWidget() {
    return errorWidget ??
        Container(
          color: Colors.grey[300],
          child: Icon(Icons.person, size: size * 0.6, color: Colors.grey[600]),
        );
  }
}
