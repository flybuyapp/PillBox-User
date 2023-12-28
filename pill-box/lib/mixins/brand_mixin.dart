import 'package:flutter/material.dart';
import 'package:flybuy/models/models.dart';
import 'package:flybuy/widgets/flybuy_cache_image.dart';
import 'package:flybuy/widgets/flybuy_shimmer.dart';

mixin BrandMixin {
  Widget buildImage(
    BuildContext context, {
    Brand? brand,
    double width = 90,
    double height = 46,
    double radius = 0,
    BoxFit fit = BoxFit.cover,
  }) {
    if (brand?.id == null) {
      return FlybuyShimmer(
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(radius)),
        ),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: FlybuyCacheImage(
        brand?.image ?? '',
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }

  Widget buildName({
    Brand? brand,
    TextStyle? style,
    TextAlign? textAlign,
    required ThemeData theme,
    double shimmerWidth = 140,
    double shimmerHeight = 16,
  }) {
    if (brand?.id == null) {
      return FlybuyShimmer(
        child: Container(
          height: shimmerHeight,
          width: shimmerWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      );
    }
    return Text(brand?.name ?? '',
        style: style ?? theme.textTheme.titleSmall, textAlign: textAlign);
  }
}
