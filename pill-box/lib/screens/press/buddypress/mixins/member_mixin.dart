import 'package:flutter/material.dart';
import 'package:flybuy/types/types.dart';
import 'package:flybuy/widgets/flybuy_cache_image.dart';
import 'package:flybuy/widgets/flybuy_shimmer.dart';

import '../models/models.dart';

mixin BPMemberMixin {
  Widget buildBanner(
      {String? banner,
      double shimmerWidth = 200,
      double shimmerHeight = 160,
      bool loading = true}) {
    if (loading) {
      return FlybuyShimmer(
        child: Container(
          height: shimmerHeight,
          width: shimmerWidth,
          color: Colors.white,
        ),
      );
    }
    return FlybuyCacheImage(
      banner,
      width: shimmerWidth,
      height: shimmerHeight,
    );
  }

  Widget buildImage({
    BPMember? data,
    double shimmerSize = 45,
  }) {
    if (data?.id == null) {
      return FlybuyShimmer(
        child: Container(
          height: shimmerSize,
          width: shimmerSize,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(shimmerSize / 2),
          ),
        ),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(shimmerSize / 2),
      child: FlybuyCacheImage(
        data?.avatar,
        width: shimmerSize,
        height: shimmerSize,
      ),
    );
  }

  Widget buildName({
    BPMember? data,
    Color? color,
    double shimmerWidth = 140,
    double shimmerHeight = 14,
    required ThemeData theme,
  }) {
    if (data?.id == null) {
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
    return Text(data?.name ?? "User",
        style: theme.textTheme.titleSmall?.copyWith(color: color));
  }

  Widget buildMentionName({
    BPMember? data,
    Color? color,
    double shimmerWidth = 140,
    double shimmerHeight = 14,
    required ThemeData theme,
  }) {
    if (data?.id == null) {
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
    return Text("@${data?.mentionName}",
        style: theme.textTheme.titleSmall?.copyWith(color: color));
  }

  Widget buildDate({
    BPMember? data,
    Color? color,
    double shimmerWidth = 80,
    double shimmerHeight = 14,
    required ThemeData theme,
    required TranslateType translate,
  }) {
    if (data?.id == null) {
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
    return Text(
      data?.lastActive?.isNotEmpty == true
          ? translate("buddypress_active", {"date": data!.lastActive!})
          : translate("buddypress_no_active"),
      style: theme.textTheme.bodySmall?.copyWith(color: color),
    );
  }

  Widget? buildFriend({
    BPMember? data,
    Widget? child,
    double shimmerWidth = 100,
    double shimmerHeight = 30,
    required ThemeData theme,
  }) {
    if (data?.id == null) {
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

    return child;
  }
}
