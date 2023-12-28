import 'package:flutter/material.dart';
import 'package:flybuy/mixins/mixins.dart';
import 'package:flybuy/models/models.dart';
import 'package:flybuy/utils/utils.dart';
import 'package:flybuy/widgets/flybuy_cache_image.dart';

class PostImage extends StatelessWidget with Utility {
  final Post? post;
  final double? width;
  final double? height;
  final Map<String, dynamic>? styles;

  const PostImage({super.key, this.post, this.width, this.height, this.styles});

  @override
  Widget build(BuildContext context) {
    String image = post?.image ?? '';
    BoxFit boxFit = BoxFit.cover;
    if (styles?.isNotEmpty == true) {
      String thumbSizes = get(styles, ['thumbSizes'], 'shop_catalog');
      String fit = get(styles, ['imageSize'], 'cover');
      image = get(post?.images, [thumbSizes], '');
      boxFit = ConvertData.toBoxFit(fit);
    }

    return FlybuyCacheImage(
      image,
      width: width,
      height: height,
      fit: boxFit,
    );
  }
}
