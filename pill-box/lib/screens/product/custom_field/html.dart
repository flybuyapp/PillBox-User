import 'package:flybuy/widgets/flybuy_webview.dart';
import 'package:flybuy/widgets/flybuy_html.dart';
import 'package:flutter/material.dart';

class FieldHtml extends StatelessWidget {
  final dynamic value;
  final double height;

  const FieldHtml({
    Key? key,
    this.value,
    this.height = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = value is String ? value : '';

    if (text.startsWith('<!DOCTYPE html>')) {
      return SizedBox(
        height: height,
        child: FlybuyWebView(
          uri: Uri.dataFromString(text, mimeType: 'text/html'),
          isLoading: false,
        ),
      );
    }
    return FlybuyHtml(html: '<div>$text</div>');
  }
}
