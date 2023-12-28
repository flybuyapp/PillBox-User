import 'package:flutter/material.dart';
import 'package:flybuy/mixins/mixins.dart';
import 'package:flybuy/store/store.dart';
import 'package:flybuy/types/types.dart';
import 'package:flybuy/utils/utils.dart';
import 'package:flybuy/widgets/widgets.dart';

import '../widgets/view_content.dart';
import 'cart_view.dart';
import 'content_view.dart';

class PointSaleScreen extends StatefulWidget {
  static const routeName = '/point_sale';
  final SettingStore? store;

  const PointSaleScreen({
    super.key,
    this.store,
  });

  @override
  State<PointSaleScreen> createState() => _PointSaleScreenState();
}

class _PointSaleScreenState extends State<PointSaleScreen> with AppBarMixin {
  bool _showCart = true;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    Color colorAppbar = theme.colorScheme.onPrimary;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        shadowColor: Colors.transparent,
        elevation: 0,
        iconTheme: theme.appBarTheme.iconTheme?.copyWith(color: colorAppbar),
        titleTextStyle:
            theme.appBarTheme.titleTextStyle?.copyWith(color: colorAppbar),
        leading: leading(),
        title: Text(translate("point_sale_txt")),
        actions: [
          FlybuyCartIcon(
            enableCount: !_showCart,
            color: Colors.transparent,
            icon: const FlybuyIconBuilder(
                data: {'type': 'feather', 'name': 'shopping-cart'}, size: 20),
            onClick: () => setState(() {
              _showCart = !_showCart;
            }),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: ViewContent(
        enableEnd: _showCart,
        startWidget: const ContentView(),
        endWidget: const CartView(),
      ),
    );
  }
}
