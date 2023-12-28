import 'package:flybuy/mixins/mixins.dart';
import 'package:flybuy/screens/cart/widgets/cart_shipping.dart';
import 'package:flybuy/store/cart/cart_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CheckoutViewShippingMethods extends StatelessWidget with LoadingMixin {
  final CartStore cartStore;

  const CheckoutViewShippingMethods({Key? key, required this.cartStore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Stack(
        children: [
          CartShipping(
            cartStore: cartStore,
            cartData: cartStore.cartData,
            changeAddress: false,
          ),
          if (cartStore.loadingShipping)
            Align(
              alignment: FractionalOffset.center,
              child: buildLoadingOverlay(context),
            ),
        ],
      ),
    );
  }
}
