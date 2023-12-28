import 'package:flutter/material.dart';
import 'package:flybuy/constants/constants.dart';
import 'package:shimmer/shimmer.dart';

class FlybuyShimmer extends StatelessWidget {
  final Widget? child;

  const FlybuyShimmer({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).dividerColor;

    if (isWeb) {
      Container c = child as Container;

      return Container(
        width: c.constraints!.minWidth,
        height: c.constraints!.minHeight,
        color: color,
      );
    }
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: child!,
    );
  }
}
