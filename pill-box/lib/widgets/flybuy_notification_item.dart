import 'package:flutter/material.dart';

import 'package:flybuy/mixins/mixins.dart';
import 'package:flybuy/mixins/notification_mixin.dart';
import 'package:flybuy/models/message/message.dart';
import 'package:flybuy/screens/profile/notification_detail.dart';
import 'package:ui/ui.dart';

class FlybuyNotificationItem extends StatelessWidget
    with NotificationMixin, NavigationMixin {
  final MessageData message;

  FlybuyNotificationItem({
    Key? key,
    required this.message,
  }) : super(key: key);

  navigateDetail(BuildContext context) {
    Navigator.of(context).pushNamed(NotificationDetail.routeName,
        arguments: {'message': message});
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return NotificationItem(
      title: buildTitle(theme, message),
      leading: buildLeading(theme, message),
      trailing: buildTrailing(message),
      date: buildDate(theme, message),
      onTap: () => navigateDetail(context),
    );
  }
}
