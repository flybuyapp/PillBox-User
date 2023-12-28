import 'package:flybuy/constants/constants.dart';
import 'package:flybuy/mixins/mixins.dart';
import 'package:flybuy/models/product_review/product_review.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import 'review_image.dart';

class FlybuyReviewProductItem extends StatelessWidget with ReviewMixin {
  final ProductReview? review;

  FlybuyReviewProductItem({Key? key, this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: paddingVerticalLarge,
          child: CommentContainedItem(
            image: buildAvatar(review: review),
            name: buildUser(review: review, theme: theme),
            comment: buildComment(review: review, theme: theme),
            date: buildDate(review: review, theme: theme),
            rating: buildRating(review: review, theme: theme),
            images: review?.id != null && review?.images?.isNotEmpty == true
                ? ReviewImage(
                    images: review!.images!,
                    reviewId: review!.id!,
                  )
                : review?.id == null
                    ? buildImages()
                    : null,
            onClick: () {},
          ),
        ),
        const Divider(height: 1, thickness: 1),
      ],
    );
  }
}
