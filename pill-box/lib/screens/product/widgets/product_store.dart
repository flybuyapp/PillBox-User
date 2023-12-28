import 'package:flutter/material.dart';
import 'package:flybuy/models/models.dart';
import 'package:flybuy/widgets/flybuy_vendor_item.dart';

class ProductStore extends StatelessWidget {
  final Product? product;

  const ProductStore({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    Vendor vendor = product is Product &&
            product!.store is Map &&
            product!.store!.isNotEmpty
        ? Vendor.fromJson(product!.store!)
        : Vendor();
    if (vendor.id == null) {
      return Container();
    }
    return FlybuyVendorItem(
      vendor: vendor,
      color: Theme.of(context).colorScheme.surface,
    );
  }
}
