import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flybuy/constants/color_block.dart';
import 'package:flybuy/models/message/message.dart';
import 'package:flybuy/utils/utils.dart';
import 'package:flybuy/widgets/flybuy_shimmer.dart';

mixin NotificationMixin {
  Widget buildTitle(ThemeData theme, MessageData messageData) {
    if (messageData.id == '') {
      return FlybuyShimmer(
        child: Container(
          height: 21,
          width: 200,
          color: Colors.white,
        ),
      );
    }
    return Text(
      messageData.payload!['title'],
      style: messageData.seen == 1
          ? theme.textTheme.titleSmall
              ?.copyWith(color: theme.textTheme.bodyLarge?.color)
          : theme.textTheme.titleSmall,
    );
  }

  Widget buildLeading(ThemeData theme, MessageData messageData) {
    if (messageData.id == '') {
      return FlybuyShimmer(
        child: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      );
    }
    return Icon(FeatherIcons.messageCircle,
        color: theme.primaryColor, size: 22);
  }

  Widget buildDate(ThemeData theme, MessageData messageData) {
    if (messageData.id == '') {
      return FlybuyShimmer(
        child: Container(
          height: 18,
          width: 124,
          color: Colors.white,
        ),
      );
    }
    return Text(
        messageData.createdAt != 'null'
            ? formatDate(
                date: messageData.createdAt.toString(), dateFormat: 'MMMM d, y')
            : '',
        style: theme.textTheme.bodySmall);
  }

  Widget? buildTrailing(MessageData messageData) {
    if (messageData.id == '') {
      return FlybuyShimmer(
        child: Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
    return messageData.seen == 1
        ? null
        : const Icon(Icons.circle, size: 8, color: ColorBlock.greenBase);
  }
}
