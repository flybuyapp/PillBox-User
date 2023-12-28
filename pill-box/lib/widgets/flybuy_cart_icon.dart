import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flybuy/constants/constants.dart';
import 'package:flybuy/mixins/mixins.dart';
import 'package:flybuy/store/auth/auth_store.dart';
import 'package:flybuy/store/cart/cart_store.dart';
import 'package:flybuy/widgets/flybuy_badge.dart';
import 'package:provider/provider.dart';

const defaultIcon = Icon(
  FeatherIcons.shoppingCart,
  size: 22.0,
);

class FlybuyCartIcon extends StatelessWidget with NavigationMixin {
  final Color? color;
  final Widget? icon;
  final bool? enableCount;
  final Widget? cartImage;
  final void Function()? onClick;

  const FlybuyCartIcon({
    Key? key,
    this.color,
    this.icon,
    this.enableCount = true,
    this.cartImage,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartStore cartStore = Provider.of<AuthStore>(context).cartStore;

    return InkResponse(
      onTap: onClick ??
          () => navigate(context, {
                'type': 'tab',
                'route': '/',
                'args': {'key': 'screens_cart'}
              }),
      child: Container(
        padding: paddingHorizontalSmall,
        height: 38,
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).appBarTheme.backgroundColor,
          borderRadius: borderRadius,
        ),
        child: Observer(
          builder: (_) => Stack(
            children: [
              Padding(
                //NGD
                  padding: const EdgeInsets.only(top: 10, right: 5),
                  child: cartImage ?? icon ?? defaultIcon),
              if (enableCount!)
                Positioned(
                  //NGD
                  left: 8,
                  top: 5,
                  child: FlybuyBadge(
                    size: 15,
                    padding: paddingHorizontalTiny,
                    label: "${cartStore.count}",
                    type: FlybuyBadgeType.error,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
