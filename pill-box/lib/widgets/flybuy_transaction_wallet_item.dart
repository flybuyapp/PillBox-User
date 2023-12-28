import 'package:flybuy/types/types.dart';
import 'package:flybuy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flybuy/mixins/mixins.dart';
import 'package:flybuy/models/models.dart';
import 'package:ui/ui.dart';

class FlybuyTransactionWalletItem extends StatelessWidget
    with TransactionWalletMixin {
  final TransactionWallet? item;

  FlybuyTransactionWalletItem({
    Key? key,
    this.item,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return TransactionWalletContainedItem(
      title: buildName(data: item, theme: theme),
      amount: buildAmount(context, data: item, theme: theme),
      type: buildType(context, data: item, theme: theme, translate: translate),
      date: buildDate(data: item, theme: theme, translate: translate),
      color: theme.colorScheme.surface,
      onClick: () => {},
    );
  }
}
