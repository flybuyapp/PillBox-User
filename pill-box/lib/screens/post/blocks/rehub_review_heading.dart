import 'package:flutter/material.dart';
import 'package:flybuy/constants/assets.dart';
import 'package:flybuy/mixins/mixins.dart';
import 'package:flybuy/utils/url_launcher.dart';
import 'package:flybuy/widgets/flybuy_cache_image.dart';
import 'package:gutenberg_blocks/gutenberg_blocks.dart';

class RehubReviewHeading extends StatelessWidget with Utility {
  final Map<String, dynamic>? block;

  const RehubReviewHeading({Key? key, this.block}) : super(key: key);

  void openUrl(String? url) {
    if (url != null && url.isNotEmpty) {
      launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    Map? attrs =
        get(block, ['attrs'], {}) is Map ? get(block, ['attrs'], {}) : {};
    bool enablePosition = get(attrs, ['includePosition'], true);
    bool enableImage = get(attrs, ['includeImage'], true);
    String? titlePosition = get(attrs, ['position'], '1');
    String title = get(attrs, ['title'], '');
    String subtitle = get(attrs, ['subtitle'], '');
    String? image = get(attrs, ['image', 'url'], Assets.noImageUrl);
    String? link = get(attrs, ['link'], '');

    Widget? imageWidget = enableImage && image!.isNotEmpty
        ? GestureDetector(
            onTap: () => openUrl(link),
            child: FlybuyCacheImage(
              image,
              width: 72,
              height: 72,
            ),
          )
        : null;
    return ReviewHeading(
      positionNumber: enablePosition && titlePosition!.isNotEmpty
          ? Text(
              titlePosition,
              style: theme.textTheme.displaySmall
                  ?.copyWith(color: theme.dividerColor),
            )
          : null,
      title: title.isNotEmpty
          ? Text(
              title,
              style: theme.textTheme.titleLarge,
            )
          : null,
      subtitle: subtitle.isNotEmpty
          ? Text(
              subtitle,
              style: theme.textTheme.bodyMedium,
            )
          : null,
      image: imageWidget,
    );
  }
}
