import 'package:flutter/material.dart';
import 'package:flybuy/models/models.dart';
import 'package:flybuy/screens/product_list/product_list.dart';
import 'package:flybuy/widgets/flybuy_cache_image.dart';
import 'package:flybuy/widgets/flybuy_shimmer.dart';
import 'package:flybuy/widgets/flybuy_tile.dart';

class ItemBrand extends StatelessWidget {
  final Brand? brand;
  final bool enableImage;
  final bool enableNumber;
  final bool enableBorderImage;

  const ItemBrand({
    Key? key,
    this.brand,
    this.enableImage = true,
    this.enableNumber = true,
    this.enableBorderImage = true,
  }) : super(key: key);

  void navigate(BuildContext context, Brand? brand) {
    if (brand is! Brand || brand.id == null) {
      return;
    }

    Navigator.of(context).pushNamed(ProductListScreen.routeName, arguments: {
      'brand': brand,
    });
  }

  Widget buildImage(ThemeData theme) {
    Border? border =
        enableBorderImage ? Border.all(color: theme.dividerColor) : null;
    if (brand == null) {
      return FlybuyShimmer(
        child: Container(
          height: 34,
          width: 71,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: Colors.white,
            border: border,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      );
    }
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        border: border,
        borderRadius: BorderRadius.circular(4),
      ),
      child: FlybuyCacheImage(
        brand?.image ?? '',
        width: 71,
        height: 34,
      ),
    );
  }

  Widget buildName(ThemeData theme) {
    if (brand == null) {
      return FlybuyShimmer(
        child: Container(
          height: 14,
          width: 120,
          color: Colors.white,
        ),
      );
    }
    String name = brand?.name ?? '';
    return RichText(
      text: TextSpan(
          text: name,
          children: [
            if (enableNumber) ...[
              if (name.isNotEmpty) const TextSpan(text: ' '),
              TextSpan(
                text: '(${brand?.count ?? 0})',
                style: theme.textTheme.labelSmall,
              )
            ],
          ],
          style: theme.textTheme.titleSmall),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return FlybuyTile(
      leading: enableImage ? buildImage(theme) : null,
      title: buildName(theme),
      isChevron: false,
      pad: 16,
      height: 66,
      onTap: () => navigate(context, brand),
    );
  }
}
