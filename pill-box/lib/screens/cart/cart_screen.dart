import 'package:flybuy/constants/constants.dart';
import 'package:flybuy/mixins/mixins.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:ui/notification/notification_screen.dart';
import 'package:flybuy/types/types.dart';
import 'package:flybuy/utils/app_localization.dart';

import 'cart_body.dart';

class CartScreen extends StatelessWidget with AppBarMixin, NavigationMixin {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    ThemeData theme = Theme.of(context);

    return CartBody(
      onBuilderAppbar: (bool enableCount, int count) {
        return AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            translate('cart_count', {'count': enableCount ? '($count)' : ''}),
            style: theme.textTheme.titleMedium,
          ),
          shadowColor: Colors.transparent,
          centerTitle: true,
          //NGD
          //leading: leading(),
        );
      },
      emptyChild: NotificationScreen(
        title:
            Text(translate('cart_no_count'), style: theme.textTheme.titleLarge),
        content: Text(
          translate('cart_is_currently_empty'),
          style: theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        iconData: FeatherIcons.shoppingCart,
        textButton: Text(translate('cart_return_shop')),
        styleBtn: ElevatedButton.styleFrom(padding: paddingHorizontalLarge),
        onPressed: () => navigate(context, {
          "type": "tab",
          "router": "/",
          "args": {"key": "screens_category"}
        }),
      ),
    );
  }
}
