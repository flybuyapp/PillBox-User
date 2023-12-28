import 'package:flybuy/mixins/loading_mixin.dart';
import 'package:flybuy/models/post/post.dart';
import 'package:flybuy/types/types.dart';
import 'package:flybuy/utils/utils.dart';
import 'package:flybuy/widgets/flybuy_divider.dart';
import 'package:flutter/material.dart';

class LayoutList extends StatelessWidget with LoadingMixin {
  final List<Post>? posts;
  final BuildItemPostType buildItem;
  final double? pad;
  final Color? dividerColor;
  final double? dividerHeight;
  final EdgeInsetsDirectional padding;
  final bool loading;
  final bool canLoadMore;
  final bool? enableLoadMore;
  final Function? onLoadMore;

  const LayoutList({
    Key? key,
    this.posts,
    required this.buildItem,
    this.pad = 0,
    this.dividerColor,
    this.dividerHeight = 1,
    this.padding = EdgeInsetsDirectional.zero,
    this.loading = false,
    this.canLoadMore = false,
    this.enableLoadMore = false,
    this.onLoadMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    int count =
        enableLoadMore! && canLoadMore ? posts!.length + 1 : posts!.length;
    return Padding(
      padding: padding,
      child: LayoutBuilder(
        builder: (_, BoxConstraints constraints) {
          double widthView = constraints.maxWidth;
          return Column(
            children: List.generate(
              count,
              (int index) {
                if (index == posts!.length) {
                  return SizedBox(
                    height: 34,
                    child: ElevatedButton(
                      onPressed: onLoadMore as void Function()?,
                      child: loading
                          ? entryLoading(context, size: 14, color: Colors.white)
                          : Text(translate('load_more')),
                    ),
                  );
                }
                return Column(
                  children: [
                    buildItem(
                      context,
                      post: posts![index],
                      index: index,
                      widthView: widthView,
                    ),
                    if (index < count - 1)
                      FlybuyDivider(
                        color: dividerColor,
                        height: pad,
                        thickness: dividerHeight,
                      )
                    else ...[
                      SizedBox(height: pad),
                      FlybuyDivider(
                        color: dividerColor,
                        height: 0,
                        thickness: dividerHeight,
                      ),
                    ]
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
