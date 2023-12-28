import 'package:flutter/material.dart';
import 'package:flybuy/webview_flutter.dart';
import 'package:flybuy/widgets/flybuy_webview.dart';

Widget buildFlybuyWebViewGateway(String url, BuildContext context,
    {String Function(String url)? customHandle}) {
  print('URL ::$url');
  if (url.contains("https://flybuy-stripe-form.web.app")) {
    print('underIfCondition');
    return FlybuyWebView(
      uri: Uri.parse(url),
      javaScriptName: "Flutter_Flybuy",
      onJavaScriptMessageReceived: (JavaScriptMessage message) {
        Navigator.pop(context, message.message);
      },
      isLoading: false,
    );
  }
  return FlybuyWebView(
    uri: Uri.parse(url),
    onNavigationRequest: (NavigationRequest request) {
      print("flubuywebview");
      if (customHandle != null) {
        String value = customHandle(request.url);
        switch (value) {
          case "prevent":
            return NavigationDecision.prevent;
          default:
            return NavigationDecision.navigate;
        }
      }
      if (request.url.contains('/order-received/')) {
        Navigator.of(context).pop({'order_received_url': request.url});
        return NavigationDecision.prevent;
      }
      return NavigationDecision.navigate;
    },
    isLoading: false,
  );
}
