import 'package:flutter/material.dart';

class FlybuyText extends StatelessWidget {
  final String? text;

  const FlybuyText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text ?? "", style: Theme.of(context).textTheme.titleSmall);
  }
}

class FlybuySubText extends StatelessWidget {
  final String text;
  final bool active;

  const FlybuySubText(this.text, {Key? key, this.active = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? activeColor = Theme.of(context).textTheme.displayLarge?.color;
    TextStyle? style = Theme.of(context).textTheme.bodyMedium;
    TextStyle? styleActive =
        Theme.of(context).textTheme.bodyMedium?.apply(color: activeColor);

    return Text(text, style: active ? styleActive : style);
  }
}
