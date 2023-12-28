import 'package:flybuy/mixins/mixins.dart';
import 'package:flybuy/models/order/order.dart';
import 'package:flybuy/screens/order/order_detail.dart';
import 'package:flybuy/screens/order/order_modal_cancel.dart';
import 'package:flybuy/store/order/order_store.dart';
import 'package:flybuy/types/types.dart';
import 'package:flybuy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class FlybuyOrderItem extends StatelessWidget with OrderMixin, NavigationMixin {
  final OrderData? order;

  final List<dynamic>? orderCancel;

  final OrderStore? orderStore;

  FlybuyOrderItem({Key? key, this.order, this.orderCancel, this.orderStore})
      : super(key: key);

  navigateDetail(BuildContext context) {
    if (order != null) {
      Navigator.of(context).pushNamed(
          "${OrderDetailScreen.routeName}/${order?.id}",
          arguments: {'orderDetail': order});
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;
    OrderData data = order ?? OrderData();
    bool isData = orderCancel?.isNotEmpty == true;
    List reqStatus = isData && orderCancel != null
        ? get(orderCancel![0], ['req-status'], [])
        : [];
    bool isCancel = reqStatus.contains('wc-${order?.status ?? ''}');
    return OrderReturnItem(
      name: buildName(theme, data),
      dateTime: buildDate(theme, data, getLocate(context)),
      code: buildCode(theme, data),
      total: buildTotal(theme, translate, data),
      price: buildPrice(context, theme, data),
      status: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          buildStatus(theme, translate, data),
          if (orderCancel != [] && orderCancel != null) ...[
            const SizedBox(height: 12),
            buildCancel(
              theme,
              translate,
              data,
              Visibility(
                visible: isData && isCancel,
                child: OrderModalCancel(
                  order: order,
                  orderCancel: orderCancel,
                  onPressed: (text) async {
                    await orderStore?.postCancelOrder(dataCancel: {
                      'order_id': "${order?.id ?? 0}",
                      'additional_details': text,
                    });
                  },
                ),
              ),
            )
          ],
        ],
      ),
      onClick: () => navigateDetail(context),
      color: theme.colorScheme.surface,
    );
  }
}
