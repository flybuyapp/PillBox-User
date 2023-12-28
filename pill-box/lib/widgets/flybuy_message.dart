import 'package:awesome_icons/awesome_icons.dart';
import 'package:flybuy/extension/strings.dart';
import 'package:flutter/material.dart';

import '../constants/styles.dart';

enum FlybuyMessageType { info, error, success }

class FlybuyMessage extends StatelessWidget {
  final String message;
  final FlybuyMessageType type;

  const FlybuyMessage({
    super.key,
    required this.message,
    this.type = FlybuyMessageType.info,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    late IconData icon;
    late Color backgroundColor;
    late Color textColor;

    switch (type) {
      case FlybuyMessageType.error:
        icon = FontAwesomeIcons.exclamationCircle;
        textColor = theme.colorScheme.onError;
        backgroundColor = theme.colorScheme.error;
        break;
      case FlybuyMessageType.success:
        icon = FontAwesomeIcons.solidCheckCircle;
        textColor = Colors.white;
        backgroundColor = Colors.green;
        break;
      default:
        icon = FontAwesomeIcons.infoCircle;
        textColor = theme.colorScheme.onSurface;
        backgroundColor = theme.colorScheme.surface;
    }

    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(
          horizontal: layoutPadding, vertical: itemPaddingMedium),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: textColor, size: 20),
          const SizedBox(width: itemPaddingSmall),
          Expanded(
            child: Text(
              message.decodeHtml,
              style: theme.textTheme.bodyMedium?.copyWith(color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}
