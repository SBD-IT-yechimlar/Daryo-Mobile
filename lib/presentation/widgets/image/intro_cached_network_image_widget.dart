import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:daryo/core/cache/CustomCacheManager.dart';
import 'package:daryo/data/datasource/network/constants/constants.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';

class IntroCachedNetworkImage extends StatelessWidget {
  final String imageId;
  final double? height;
  final double? width;
  final Widget? placeHolderIcon;
  final Widget? errorIcon;

  const IntroCachedNetworkImage({
    super.key,
    required this.imageId,
    this.width,
    this.height,
    this.placeHolderIcon,
    this.errorIcon,
  });

  @override
  Widget build(BuildContext context) {
    var actualUrl = imageId.contains("https://") || imageId.contains("http://")
        ? imageId
        : "${Constants.baseUrlForImage}$imageId";

    return CachedNetworkImage(
        width: width,
        height: height,
        imageUrl: actualUrl,
        cacheManager: CustomCacheManager.imageCacheManager,
        fadeInDuration: const Duration(milliseconds: 500),
        fadeOutDuration: const Duration(milliseconds: 300),
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        placeholder: (context, url) {
          // Logger().w("IntroCachedNetworkImage url = $actualUrl");
          return Container(
            decoration: BoxDecoration(color: context.cardColor),
            child: placeHolderIcon != null
                ? Center(child: placeHolderIcon)
                : Center(),
          );
        },
        errorWidget: (context, url, error) {
          // Logger().w("IntroCachedNetworkImage error = $error");
          return Container(
            decoration: BoxDecoration(color: context.cardColor),
            child: errorIcon != null ? Center(child: errorIcon) : Center(),
          );
        });
  }
}
