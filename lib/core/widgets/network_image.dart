import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/theme/colors_manager.dart';
import 'shimmer.dart';

class _AppCashedImage extends StatelessWidget {
  final String imageUrl;
  final double? radius, width, height;
  final BoxFit? fit;
  final Color? borderColor;
  final double? borderWidth;
  final bool isCircular;
  final Color? color;

  const _AppCashedImage({
    required this.imageUrl,
    this.width,
    this.height,
    this.radius,
    this.fit,
    this.borderColor,
    this.borderWidth,
    this.isCircular = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border:
            borderColor == null
                ? null
                : Border.all(
                  color: borderColor ?? Theme.of(context).primaryColor,
                  width: borderWidth ?? 0,
                ),
        shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircular ? null : BorderRadius.circular(radius ?? 12),
      ),
      child: CachedNetworkImage(
        imageBuilder:
            (context, imageProvider) => Container(
              decoration: BoxDecoration(
                color: color ?? ColorsManager.primary.withValues(alpha: .2),
                shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
                borderRadius:
                    isCircular
                        ? null
                        : BorderRadius.only(
                          topLeft: Radius.circular(radius ?? 12),
                          topRight: Radius.circular(radius ?? 12),
                          bottomLeft: Radius.circular(radius ?? 12),
                          bottomRight: Radius.circular(radius ?? 12),
                        ),
                image: DecorationImage(
                  image: imageProvider,
                  fit: fit ?? BoxFit.cover,
                ),
              ),
            ),
        imageUrl: imageUrl,
        width: width,
        height: height,
        progressIndicatorBuilder:
            (context, url, downloadProgress) => MainShimmerWidget(
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
                  borderRadius:
                      isCircular
                          ? null
                          : BorderRadius.only(
                            topLeft: Radius.circular(radius ?? 12),
                            topRight: Radius.circular(radius ?? 12),
                            bottomLeft: Radius.circular(radius ?? 12),
                            bottomRight: Radius.circular(radius ?? 12),
                          ),
                ),
              ),
            ),
        errorWidget:
            (context, url, error) => Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
                borderRadius:
                    isCircular
                        ? null
                        : BorderRadius.only(
                          topLeft: Radius.circular(radius ?? 12),
                          topRight: Radius.circular(radius ?? 12),
                          bottomLeft: Radius.circular(radius ?? 12),
                          bottomRight: Radius.circular(radius ?? 12),
                        ),
              ),
              child: ClipRRect(
                borderRadius:
                    isCircular
                        ? BorderRadius.circular(height ?? 100 / 2)
                        : BorderRadius.only(
                          topLeft: Radius.circular(radius ?? 12),
                          topRight: Radius.circular(radius ?? 12),
                          bottomLeft: Radius.circular(radius ?? 12),
                          bottomRight: Radius.circular(radius ?? 12),
                        ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.error,
                    color: ColorsManager.darkGrey.withAlpha(70),
                    size: (height ?? 100) / 7,
                  ),
                ),
              ),
            ),
      ),
    );
  }
}

enum ImageFormat { svg, png, jpeg, gif, unknown }

class MainNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? radius, width, height;
  final BoxFit? fit;
  final Color? borderColor;
  final double? borderWidth;
  final bool isCircular;
  final Color? color;

  const MainNetworkImage({
    required this.imageUrl,
    this.width,
    this.height = 200,
    this.radius,
    this.fit,
    this.borderColor,
    this.borderWidth,
    this.isCircular = false,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ImageFormat format = _getImageFormat(imageUrl);
    switch (format) {
      case ImageFormat.svg:
        return SvgPicture.network(
          imageUrl,
          width: width,
          height: height,
          fit: fit ?? BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                border: Border.all(color: ColorsManager.primary),
                shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
                borderRadius:
                    isCircular
                        ? null
                        : BorderRadius.only(
                          topLeft: Radius.circular(radius ?? 12),
                          topRight: Radius.circular(radius ?? 12),
                          bottomLeft: Radius.circular(radius ?? 12),
                          bottomRight: Radius.circular(radius ?? 12),
                        ),
              ),
              child: ClipRRect(
                borderRadius:
                    isCircular
                        ? BorderRadius.circular(height ?? 100 / 2)
                        : BorderRadius.only(
                          topLeft: Radius.circular(radius ?? 12),
                          topRight: Radius.circular(radius ?? 12),
                          bottomLeft: Radius.circular(radius ?? 12),
                          bottomRight: Radius.circular(radius ?? 12),
                        ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.error,
                      color: ColorsManager.darkGrey.withAlpha(70),
                      size: (height ?? 100) / 7,
                    ),
                  ),
                ),
              ),
            );
          },
          placeholderBuilder: (context) {
            return MainShimmerWidget(
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorsManager.primary),
                  shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
                  borderRadius:
                      isCircular
                          ? null
                          : BorderRadius.only(
                            topLeft: Radius.circular(radius ?? 12),
                            topRight: Radius.circular(radius ?? 12),
                            bottomLeft: Radius.circular(radius ?? 12),
                            bottomRight: Radius.circular(radius ?? 12),
                          ),
                ),
              ),
            );
          },
        );
      case ImageFormat.png:
      case ImageFormat.jpeg:
      case ImageFormat.gif:
        return _AppCashedImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          radius: radius,
          fit: fit,
          borderColor: borderColor,
          borderWidth: borderWidth,
          isCircular: isCircular,
          color: color,
        );
      case ImageFormat.unknown:
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            border: Border.all(color: ColorsManager.primary),
            shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
            borderRadius:
                isCircular
                    ? null
                    : BorderRadius.only(
                      topLeft: Radius.circular(radius ?? 12),
                      topRight: Radius.circular(radius ?? 12),
                      bottomLeft: Radius.circular(radius ?? 12),
                      bottomRight: Radius.circular(radius ?? 12),
                    ),
          ),
          child: ClipRRect(
            borderRadius:
                isCircular
                    ? BorderRadius.circular(height ?? 100 / 2)
                    : BorderRadius.only(
                      topLeft: Radius.circular(radius ?? 12),
                      topRight: Radius.circular(radius ?? 12),
                      bottomLeft: Radius.circular(radius ?? 12),
                      bottomRight: Radius.circular(radius ?? 12),
                    ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.error,
                  color: ColorsManager.darkGrey.withAlpha(70),
                  size: (height ?? 100) / 7,
                ),
              ),
            ),
          ),
        );
    }
  }

  /// Determines the image format based on the URL extension
  ImageFormat _getImageFormat(String url) {
    final String lowerUrl = url.toLowerCase();
    if (lowerUrl.endsWith('.svg')) {
      return ImageFormat.svg;
    } else if (lowerUrl.endsWith('.png')) {
      return ImageFormat.png;
    } else if (lowerUrl.endsWith('.jpg') || lowerUrl.endsWith('.jpeg')) {
      return ImageFormat.jpeg;
    } else {
      return ImageFormat.unknown;
    }
  }
}
