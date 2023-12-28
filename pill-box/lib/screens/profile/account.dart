import 'package:flybuy/constants/constants.dart';
import 'package:flybuy/mixins/mixins.dart';
import 'package:flybuy/models/models.dart';
import 'package:flybuy/screens/screens.dart';
import 'package:flybuy/store/store.dart';
import 'package:flybuy/types/types.dart';
import 'package:flybuy/utils/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flybuy/widgets/flybuy_tile.dart';

class AccountScreen extends StatelessWidget with AppBarMixin {
  static const String routeName = '/profile/account';

  final SettingStore? store;

  const AccountScreen({
    Key? key,
    this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;
    WidgetConfig? widgetConfig =
        store?.data?.screens?['profile']?.widgets?['profilePage']!;
    Map<String, dynamic>? fields = widgetConfig?.fields;

    bool enableAddressBook = get(fields, ['enableAddressBook'], false);

    return Scaffold(
      appBar: baseStyleAppBar(context,
          title: translate('edit_account_your_account')),
      body: SingleChildScrollView(
        padding: paddingHorizontal,
        child: Column(
          children: [
            FlybuyTile(
              title: Text(translate('edit_account'),
                  style: theme.textTheme.titleSmall),
              onTap: () =>
                  Navigator.of(context).pushNamed(EditAccountScreen.routeName),
            ),
            // FlybuyTile(
            //   title: Text(translate('change_phone'), style: theme.textTheme.titleSmall),
            //   onTap: () {},
            // ),
            FlybuyTile(
              title: Text(translate('change_password'),
                  style: theme.textTheme.titleSmall),
              onTap: () => Navigator.of(context)
                  .pushNamed(ChangePasswordScreen.routeName),
            ),
            if (enableAddressBook)
              FlybuyTile(
                title: Text(translate('address_book_txt'),
                    style: theme.textTheme.titleSmall),
                onTap: () => Navigator.of(context)
                    .pushNamed(AddressBookScreen.routeName),
              )
            else ...[
              FlybuyTile(
                title: Text(translate('address_billing'),
                    style: theme.textTheme.titleSmall),
                onTap: () => Navigator.of(context)
                    .pushNamed(AddressBillingScreen.routeName),
              ),
              FlybuyTile(
                title: Text(translate('address_shipping'),
                    style: theme.textTheme.titleSmall),
                onTap: () => Navigator.of(context)
                    .pushNamed(AddressShippingScreen.routeName),
              ),
            ],
            FlybuyTile(
              title: Text(translate('delete_account_txt'),
                  style: theme.textTheme.titleSmall),
              onTap: () => Navigator.of(context)
                  .pushNamed(DeleteAccountScreen.routeName),
            ),
          ],
        ),
      ),
    );
  }
}
