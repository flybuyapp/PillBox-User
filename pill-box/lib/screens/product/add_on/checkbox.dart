import 'package:flutter/material.dart';
import 'package:flybuy/constants/styles.dart';
import 'package:flybuy/mixins/mixins.dart';
import 'package:flybuy/screens/product/add_on/model.dart';
import 'package:flybuy/types/types.dart';
import 'package:flybuy/utils/utils.dart';
import 'package:flybuy/widgets/widgets.dart';

import 'helper.dart';

class CheckboxField extends StatelessWidget with Utility {
  final List options;
  final Function(AddOnData) onChange;
  final AddOnData? value;
  final bool showPrice;
  final bool showDuration;
  final String? error;

  const CheckboxField({
    Key? key,
    required this.options,
    required this.onChange,
    this.value,
    this.showPrice = false,
    this.showDuration = false,
    this.error,
  }) : super(key: key);

  Widget buildTrailing({
    String price = '',
    String duration = '',
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (price.isNotEmpty) Text('+$price'),
        if (price.isNotEmpty && duration.isNotEmpty) const SizedBox(width: 10),
        if (duration.isNotEmpty) Text(duration),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    List<AddOnOption>? data = value?.listOption;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(options.length, (index) {
          Map<String, dynamic> option = options[index];
          String label = option['label'] ?? '';
          String price = getTextPrice(context, option: option);
          String duration =
              getTextDuration(context, option: option, translate: translate);

          bool isSelect = data?.isNotEmpty == true
              ? data!
                  .where((element) => element.visit == index)
                  .toSet()
                  .isNotEmpty
              : false;
          return FlybuyTile(
            leading: FlybuyRadio.iconCheck(isSelect: isSelect),
            title: Text(label),
            trailing: (showPrice && price.isNotEmpty) ||
                    (showDuration && duration.isNotEmpty)
                ? buildTrailing(price: price)
                : null,
            onTap: () {
              List<AddOnOption> dataOptionVisit = [...?data];

              if (isSelect) {
                int visit = dataOptionVisit
                    .indexWhere((element) => element.visit == index);
                dataOptionVisit.removeAt(visit);
              } else {
                String priceType = get(option, ['price_type'], 'flat_fee');
                double price = getPrice(context, option: option);

                String durationType =
                    get(option, ['duration_type'], 'flat_time');
                double duration = getDuration(context, option: option);
                String sanitizeLabel = get(option, ['sanitize_label'], '');

                dataOptionVisit.add(AddOnOption(
                  visit: index,
                  value: sanitizeLabel,
                  price: price,
                  duration: duration,
                  priceType: priceType,
                  durationType: durationType,
                ));
              }

              onChange(
                AddOnData(
                    type: AddOnDataType.listOption,
                    listOption: dataOptionVisit),
              );
            },
            pad: 10,
            isChevron: false,
          );
        }),
        if (error != null) ...[
          const SizedBox(height: itemPadding),
          Text(error ?? '',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.error)),
        ],
      ],
    );
  }
}
