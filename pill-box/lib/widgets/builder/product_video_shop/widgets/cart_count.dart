import 'package:flybuy/constants/constants.dart';
import 'package:flybuy/store/auth/auth_store.dart';
import 'package:flybuy/store/cart/cart_store.dart';
import 'package:flybuy/widgets/flybuy_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class CartCountVideoShop extends StatelessWidget {
  const CartCountVideoShop({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    CartStore cartStore = Provider.of<AuthStore>(context).cartStore;
    return Observer(
      builder: (context) {
        return FlybuyBadge(
          size: 18,
          padding: paddingHorizontalTiny,
          label: "${cartStore.cartData?.itemsCount ?? 0}",
          type: FlybuyBadgeType.error,
        );
      },
    );
  }
}
