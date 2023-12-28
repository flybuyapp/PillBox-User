import 'package:awesome_icons/awesome_icons.dart';
import 'package:flybuy/mixins/mixins.dart';
import 'package:flybuy/models/models.dart';
import 'package:flybuy/types/types.dart';
import 'package:flybuy/utils/utils.dart';
import 'package:flybuy/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ui/ui.dart';

class AddressItem extends StatelessWidget with Utility {
  final AddressBookData address;
  final bool primary;
  final List<String>? actions;
  final void Function(String)? onSelectAction;
  final EdgeInsetsGeometry? padding;

  const AddressItem({
    super.key,
    required this.address,
    this.primary = false,
    this.actions,
    this.onSelectAction,
    this.padding,
  });

  Widget buildIcon(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Icon(
        FontAwesomeIcons.addressBook,
        size: 16,
        color: primary ? theme.primaryColor : null,
      ),
    );
  }

  Widget buildAddress(ThemeData theme) {
    return FlybuyHtml(
      html: address.address ?? '',
      style: {
        'body': Style(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
        ),
      },
    );
  }

  String nameAction(String type, TranslateType translate) {
    switch (type) {
      case 'edit':
        return translate('address_book_edit');
      case 'delete':
        return translate('address_book_delete');
      case 'primary':
        return translate('address_book_primary');
      default:
        return '';
    }
  }

  Widget buildAction(ThemeData theme, TranslateType translate) {
    return PopupMenuButton<String>(
      onSelected: (String item) => onSelectAction?.call(item),
      itemBuilder: (BuildContext context) =>
          List.generate(actions!.length, (index) {
        String value = actions![index];
        return PopupMenuItem<String>(
          value: value,
          padding: EdgeInsets.zero,
          height: 42,
          child: FlybuyTile(
            title: Text(nameAction(value, translate),
                style: theme.textTheme.bodyMedium),
            height: 42,
            isChevron: false,
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        );
      }).toList(),
      constraints: const BoxConstraints(minWidth: 100, minHeight: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      padding: EdgeInsets.zero,
      elevation: 2,
      tooltip: '',
      child: Text(translate('address_book_action'),
          style: theme.textTheme.labelLarge),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return AddressBookItem(
      icon: buildIcon(theme),
      action:
          actions?.isNotEmpty == true ? buildAction(theme, translate) : null,
      address: buildAddress(theme),
      padding: padding,
    );
  }
}
