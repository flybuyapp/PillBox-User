import 'package:flybuy/constants/constants.dart';
import 'package:flybuy/mixins/transition_mixin.dart';
import 'package:flybuy/models/product/product.dart';
import 'package:flybuy/service/helpers/request_helper.dart';
import 'package:flybuy/store/product/review_store.dart';
import 'package:flybuy/store/setting/setting_store.dart';
import 'package:flybuy/types/types.dart';
import 'package:flybuy/utils/utils.dart';
import 'package:flybuy/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'product_review_list.dart';

class ProductReview extends StatefulWidget {
  final Product? product;
  final bool? expand;
  final String? align;

  const ProductReview(
      {Key? key, this.product, this.expand, this.align = 'left'})
      : super(key: key);

  @override
  State<ProductReview> createState() => _ProductReviewState();
}

class _ProductReviewState extends State<ProductReview> with TransitionMixin {
  ProductReviewStore? _productReviewStore;

  @override
  void didChangeDependencies() {
    _productReviewStore = ProductReviewStore(
      Provider.of<RequestHelper>(context),
      productId: widget.product!.id,
      lang: Provider.of<SettingStore>(context).locale,
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    if (widget.expand!) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              translate('product_reviews'),
              style: theme.textTheme.titleMedium,
              textAlign: ConvertData.toTextAlignDirection(widget.align),
            ),
          ),
          Padding(
            padding: paddingVerticalMedium,
            child: BasicInfoReview(
                product: widget.product, store: _productReviewStore),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, _, __) => ProductReviewList(
                      product: widget.product, store: _productReviewStore),
                  transitionsBuilder: slideTransition,
                ),
              );
            },
            child: Text(translate('product_all_reviews')),
          )
        ],
      );
    }

    return FlybuyTile(
      title:
          Text(translate('product_reviews'), style: theme.textTheme.titleSmall),
      isDivider: false,
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, _, __) => ProductReviewList(
              product: widget.product,
              store: _productReviewStore,
            ),
            transitionsBuilder: slideTransition,
          ),
        );
      },
    );
  }
}
