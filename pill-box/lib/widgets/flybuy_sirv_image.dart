import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iframe_view/iframe_view.dart';
import 'flybuy_webview.dart';

class FlybuySirvImage extends StatefulWidget {
  final String video;

  const FlybuySirvImage({Key? key, required this.video}) : super(key: key);

  @override
  State<FlybuySirvImage> createState() => _FlybuySirvImageState();
}

class _FlybuySirvImageState extends State<FlybuySirvImage> {
  final _iframeViewPlugin = IframeView();

  Widget _build360Spin() {
    String html = """
    <script src="https://scripts.sirv.com/sirv.js"></script>
    <div class="Sirv" data-src="${widget.video}"></div>
    """;

    if (kIsWeb) {
      return FutureBuilder<Widget?>(
          future: _iframeViewPlugin
              .show(Uri.dataFromString(html, mimeType: 'text/html').toString()),
          builder: (BuildContext context, AsyncSnapshot<Widget?> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return snapshot.data!;
            }
            return const SizedBox();
          });
    }

    return FlybuyWebView(
      uri: Uri.dataFromString(html, mimeType: 'text/html'),
      isLoading: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: _build360Spin(),
    );
  }
}
