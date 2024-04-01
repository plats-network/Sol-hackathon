import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plat_app/app/widgets/app_shimmer.dart';
import 'package:plat_app/app/widgets/error_image.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';

class AppCachedImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit? fit;
  final double? cornerRadius;
  final Color? backgroundColor;

  const AppCachedImage(
      {Key? key,
      required this.imageUrl,
      required this.width,
      required this.height,
      this.cornerRadius,
      this.fit,
      this.backgroundColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return imageUrl.isNotEmpty
        ? CachedNetworkImage(
            imageUrl: imageUrl,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                image: DecorationImage(
                  image: imageProvider,
                  fit: fit ?? BoxFit.cover,
                ),
                borderRadius:
                    BorderRadius.all(Radius.circular(cornerRadius ?? 0)),
              ),
            ),
            placeholder: (context, url) => AppShimmer(
              cornerRadius: cornerRadius ?? 0,
            ),
            errorWidget: (context, url, error) =>
                imageErrorWidgetBuilderWidthHeight(
                    context, error, StackTrace.current,
                    width: width,
                    height: height,
                    borderRadius: BorderRadius.circular(cornerRadius ?? 0)),
            width: width,
            height: height,
          )
        : Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius:
                  BorderRadius.all(Radius.circular(cornerRadius ?? 0)),
            ),
          );
  }
}
