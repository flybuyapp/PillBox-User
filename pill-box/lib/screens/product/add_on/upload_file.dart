import 'package:flybuy/constants/styles.dart';
import 'package:flybuy/types/types.dart';
import 'package:flybuy/utils/utils.dart';
import 'package:flybuy/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'model.dart';

class UploadFileField extends StatelessWidget {
  final Map<String, dynamic> item;
  final Function onChange;
  final AddOnData? value;
  final String? error;

  const UploadFileField({
    super.key,
    required this.item,
    required this.onChange,
    this.value,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FlybuyPicker(
          value: value?.file,
          onChange: (data) {
            onChange(AddOnData(
              type: AddOnDataType.file,
              file: data,
            ));
          },
        ),
        const SizedBox(height: 4),
        Text(translate("product_file_size"), style: theme.textTheme.bodySmall),
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
