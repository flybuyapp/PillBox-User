import 'package:flutter/cupertino.dart';
import 'flybuy_webview.dart';

class FlybuyInstagram extends StatefulWidget {
  final String id;

  const FlybuyInstagram({Key? key, required this.id}) : super(key: key);

  @override
  State<FlybuyInstagram> createState() => _FlybuyInstagramState();
}

class _FlybuyInstagramState extends State<FlybuyInstagram> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 625,
      child: FlybuyWebView(
        uri: Uri.dataFromString(
          '<iframe frameBorder="0" height="100%" width="100%" src="https://www.instagram.com/p/${widget.id}/embed/"></iframe>',
          mimeType: 'text/html',
        ),
        isLoading: false,
      ),
    );
  }
}
