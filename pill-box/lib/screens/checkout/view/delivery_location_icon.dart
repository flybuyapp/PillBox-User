import 'package:flybuy/mixins/general_mixin.dart';
import 'package:flybuy/models/location/place.dart';
import 'package:flybuy/models/location/user_location.dart';
import 'package:flybuy/screens/location/select_location.dart';
import 'package:flybuy/store/cart/checkout_store.dart';
import 'package:flybuy/store/store.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class DeliveryLocationIcon extends StatelessWidget with GeneralMixin {
  const DeliveryLocationIcon({Key? key, required this.callback})
      : super(key: key);
  final Function(Place place, {String? address2}) callback;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    CheckoutStore checkoutStore =
        Provider.of<AuthStore>(context).cartStore.checkoutStore;
    SettingStore settingStore = Provider.of<SettingStore>(context);
    bool pickupAddress = getConfig(settingStore, ['pickupAddress'], false);

    return (pickupAddress)
        ? IconButton(
            splashRadius: 20,
            onPressed: () async {
              FocusScope.of(context).unfocus();
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectLocationScreen(
                    location: checkoutStore.deliveryLocation,
                  ),
                ),
              );
              if (result != null) {
                if (result['user_location'] is UserLocation) {
                  UserLocation location = result['user_location'];
                  if (location.lat != checkoutStore.deliveryLocation?.lat ||
                      location.lng != checkoutStore.deliveryLocation?.lng) {
                    checkoutStore.deliveryLocation = location;
                  }
                }
                if (result['place'] is Place) {
                  Place place = result['place'];
                  callback(place, address2: result['address2']);
                }
              }
            },
            icon: Icon(
              Icons.my_location,
              size: 16,
              color: theme.textTheme.titleMedium?.color,
            ))
        : const SizedBox.shrink();
  }
}
